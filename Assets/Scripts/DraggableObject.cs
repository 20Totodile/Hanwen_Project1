using UnityEngine;

/// <summary>
/// 点击并按住鼠标，将物体沿世界坐标的 YZ 平面拖动。
/// 物体需要 Collider，摄像机需要 MainCamera 标签。
/// </summary>
[RequireComponent(typeof(Collider), typeof(Rigidbody))]
public class DraggableObject : MonoBehaviour
{
    [Header("Holding")]
    [SerializeField, Min(0f)] private float pickupLift = 0.35f;
    [SerializeField] private Vector3 heldEulerAngles = new Vector3(0f, 0f, 180f);

    [Header("Release")]
    [SerializeField, Min(0f)] private float toppleTorque = 0.35f;

    private Camera mainCamera;
    private Rigidbody body;
    private Plane dragPlane;
    private Vector3 dragOffset;
    private bool isDragging;
    private CapsuleCollider poleCollider;
    private SkewerableMeat[] skewerTargets;
    private SkewerableMeat attachedMeat;
    private float lockedWorldX;
    private bool placedSuccessfully;

    private void Awake()
    {
        mainCamera = Camera.main;
        body = GetComponent<Rigidbody>();
        if (body == null) body = gameObject.AddComponent<Rigidbody>();
        poleCollider = GetComponent<CapsuleCollider>();
        lockedWorldX = transform.position.x;
        body.constraints |= RigidbodyConstraints.FreezePositionX;
    }

    private void OnMouseDown()
    {
        if (placedSuccessfully) return;

        if (mainCamera == null) mainCamera = Camera.main;
        if (mainCamera == null) return;

        body.velocity = Vector3.zero;
        body.angularVelocity = Vector3.zero;
        body.useGravity = false;
        body.isKinematic = true;
        Vector3 pickupPosition = transform.position;
        pickupPosition.x = lockedWorldX;
        transform.position = pickupPosition;
        transform.rotation = Quaternion.Euler(heldEulerAngles);

        if (attachedMeat == null)
        {
            skewerTargets = FindObjectsOfType<SkewerableMeat>();
            Vector3 tip = GetSkewerTip();
            foreach (SkewerableMeat target in skewerTargets)
                target.BeginTracking(tip, poleCollider);
        }

        // 法线朝 X，因此这个拖拽平面允许物体沿世界 Y / Z 移动，X 保持不变。
        dragPlane = new Plane(Vector3.right, transform.position);

        Ray ray = mainCamera.ScreenPointToRay(Input.mousePosition);
        if (!dragPlane.Raycast(ray, out float distance)) return;

        Vector3 planePoint = ray.GetPoint(distance);
        dragOffset = transform.position - planePoint;
        dragOffset.y += pickupLift;

        isDragging = true;
        MoveToMouse();
    }

    private void OnMouseDrag()
    {
        if (isDragging) MoveToMouse();
    }

    private void OnMouseUp()
    {
        isDragging = false;

        if (attachedMeat != null)
        {
            PlateGoal plate = FindObjectOfType<PlateGoal>();
            if (plate != null && plate.TryPlace(attachedMeat))
            {
                placedSuccessfully = true;
                body.useGravity = false;
                body.isKinematic = true;
                return;
            }
        }
        else if (skewerTargets != null)
        {
            foreach (SkewerableMeat target in skewerTargets)
                if (target != null) target.EndTracking();
        }

        body.isKinematic = false;
        body.useGravity = true;

        // 完全竖直的物体可能在平面上保持平衡；给它轻微侧向扭矩使其自然倒下。
        Vector3 toppleDirection = mainCamera != null
            ? mainCamera.transform.right
            : Vector3.right;
        body.AddTorque(toppleDirection * toppleTorque, ForceMode.Impulse);
    }

    private void MoveToMouse()
    {
        Ray ray = mainCamera.ScreenPointToRay(Input.mousePosition);
        if (dragPlane.Raycast(ray, out float distance))
        {
            transform.position = ray.GetPoint(distance) + dragOffset;
            CheckSkewerTargets();
        }
    }

    private void CheckSkewerTargets()
    {
        if (attachedMeat != null || skewerTargets == null) return;

        Vector3 tip = GetSkewerTip();
        foreach (SkewerableMeat target in skewerTargets)
        {
            if (target != null && target.TrackTip(tip, transform))
            {
                attachedMeat = target;
                break;
            }
        }
    }

    private Vector3 GetSkewerTip()
    {
        if (poleCollider == null) return transform.position;

        // Unity Capsule 的长轴是局部 Y。拿起时旋转 180° 后，局部 +Y 端朝下。
        Vector3 localTip = poleCollider.center + Vector3.up * (poleCollider.height * 0.5f);
        return transform.TransformPoint(localTip);
    }
}
