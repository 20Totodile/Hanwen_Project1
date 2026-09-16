using UnityEngine;

/// <summary>
/// 检测签子是否从肉块顶部进入，并在穿透达到指定比例后吸附到签子。
/// </summary>
[RequireComponent(typeof(BoxCollider), typeof(Rigidbody))]
public class SkewerableMeat : MonoBehaviour
{
    [Header("Entry")]
    [SerializeField, Range(0.1f, 1f)] private float topEntryArea = 0.8f;

    [Header("Success")]
    [SerializeField, Range(0.5f, 1f)] private float requiredPenetration = 0.9f;
    [SerializeField, Min(0f)] private float collisionSkin = 0.005f;

    private BoxCollider meatCollider;
    private Rigidbody meatBody;
    private Vector3 previousLocalTip;
    private bool tracking;
    private bool enteredFromTop;
    private bool attached;
    private Collider activeSkewerCollider;
    private Transform attachedSkewer;
    private Vector3 skewerRelativePosition;
    private Quaternion skewerRelativeRotation;
    private Collider tableCollider;

    private void Awake()
    {
        meatCollider = GetComponent<BoxCollider>();
        meatBody = GetComponent<Rigidbody>();
        if (meatBody == null) meatBody = gameObject.AddComponent<Rigidbody>();
        meatBody.useGravity = true;
        meatBody.isKinematic = false;
        meatBody.interpolation = RigidbodyInterpolation.Interpolate;
        meatBody.collisionDetectionMode = CollisionDetectionMode.Continuous;

        GameObject table = GameObject.Find("table");
        if (table != null) tableCollider = table.GetComponent<Collider>();
    }

    private void LateUpdate()
    {
        if (!attached || attachedSkewer == null) return;

        // 只继承签子的位置和旋转，不继承它的非等比 Scale。
        transform.position = attachedSkewer.position +
            attachedSkewer.rotation * skewerRelativePosition;
        transform.rotation = attachedSkewer.rotation * skewerRelativeRotation;
        ClampAboveTable();
        ResolveEnvironmentPenetration();
    }

    public void BeginTracking(Vector3 worldTip, Collider skewerCollider)
    {
        if (attached) return;
        previousLocalTip = transform.InverseTransformPoint(worldTip);
        tracking = true;
        enteredFromTop = false;

        activeSkewerCollider = skewerCollider;
        if (activeSkewerCollider != null)
            Physics.IgnoreCollision(activeSkewerCollider, meatCollider, true);
    }

    public bool TrackTip(Vector3 worldTip, Transform skewer)
    {
        if (attached) return true;
        if (!tracking) BeginTracking(worldTip, skewer.GetComponent<Collider>());

        Vector3 localTip = transform.InverseTransformPoint(worldTip);
        Vector3 center = meatCollider.center;
        Vector3 half = meatCollider.size * 0.5f;
        float top = center.y + half.y;
        float bottom = center.y - half.y;

        float allowedX = half.x * topEntryArea;
        float allowedZ = half.z * topEntryArea;
        bool insideTopArea =
            Mathf.Abs(localTip.x - center.x) <= allowedX &&
            Mathf.Abs(localTip.z - center.z) <= allowedZ;

        bool crossedTopDownward =
            previousLocalTip.y > top &&
            localTip.y <= top &&
            localTip.y < previousLocalTip.y;

        if (!enteredFromTop && insideTopArea && crossedTopDownward)
        {
            enteredFromTop = true;
            Debug.Log("签子已从肉块顶部进入，开始计算穿透深度。", this);
        }

        if (enteredFromTop)
        {
            // 离开顶部范围或从顶部拔出时，取消本次穿刺。
            if (!insideTopArea || localTip.y > top)
            {
                enteredFromTop = false;
            }
            else
            {
                float penetration = Mathf.InverseLerp(top, bottom, localTip.y);
                if (penetration >= requiredPenetration)
                {
                    AttachToSkewer(skewer);
                    return true;
                }
            }
        }

        previousLocalTip = localTip;
        return false;
    }

    public void EndTracking()
    {
        if (attached) return;

        tracking = false;
        enteredFromTop = false;
        RestoreSkewerCollision();
    }

    private void AttachToSkewer(Transform skewer)
    {
        attached = true;
        enteredFromTop = false;

        meatBody.velocity = Vector3.zero;
        meatBody.angularVelocity = Vector3.zero;
        meatBody.isKinematic = true;
        meatBody.useGravity = false;

        // 不建立父子关系，避免签子的非等比 Scale 改变肉块的位置和形状。
        attachedSkewer = skewer;
        skewerRelativePosition = Quaternion.Inverse(skewer.rotation) *
            (transform.position - skewer.position);
        skewerRelativeRotation = Quaternion.Inverse(skewer.rotation) * transform.rotation;
        Debug.Log("穿透达到 90%，肉块已吸附到签子。", this);
    }

    public Bounds WorldBounds => meatCollider.bounds;

    public void SettleOnPlate(Vector3 worldPosition)
    {
        if (attachedSkewer != null)
        {
            // 整体移动签子，使肉到达盘中；保持两者原有的穿刺相对位置。
            attachedSkewer.position += worldPosition - transform.position;
        }

        transform.position = worldPosition;
        tracking = false;
        enteredFromTop = false;

        meatBody.isKinematic = true;
        meatBody.useGravity = false;
    }

    private void RestoreSkewerCollision()
    {
        if (activeSkewerCollider != null && meatCollider != null)
            Physics.IgnoreCollision(activeSkewerCollider, meatCollider, false);

        activeSkewerCollider = null;
    }

    private void ResolveEnvironmentPenetration()
    {
        Vector3 center = transform.TransformPoint(meatCollider.center);
        Vector3 scale = transform.lossyScale;
        Vector3 halfExtents = Vector3.Scale(
            meatCollider.size * 0.5f,
            new Vector3(Mathf.Abs(scale.x), Mathf.Abs(scale.y), Mathf.Abs(scale.z))
        );

        // 多轮修正可以处理肉块同时接触桌面和盘子边缘的情况。
        for (int pass = 0; pass < 3; pass++)
        {
            Collider[] overlaps = Physics.OverlapBox(
                center,
                halfExtents * 0.99f,
                transform.rotation,
                ~0,
                QueryTriggerInteraction.Ignore
            );

            bool corrected = false;
            foreach (Collider other in overlaps)
            {
                if (other == meatCollider || other == activeSkewerCollider) continue;

                if (Physics.ComputePenetration(
                    meatCollider,
                    transform.position,
                    transform.rotation,
                    other,
                    other.transform.position,
                    other.transform.rotation,
                    out Vector3 direction,
                    out float distance))
                {
                    Vector3 correction = direction * (distance + collisionSkin);
                    transform.position += correction;
                    center += correction;
                    corrected = true;
                }
            }

            if (!corrected) break;
        }
    }

    private void ClampAboveTable()
    {
        if (tableCollider == null) return;

        float tableTop = tableCollider.bounds.max.y;
        float meatBottom = meatCollider.bounds.min.y;
        float minimumBottom = tableTop + collisionSkin;

        if (meatBottom < minimumBottom)
        {
            Vector3 position = transform.position;
            position.y += minimumBottom - meatBottom;
            transform.position = position;
        }
    }
}
