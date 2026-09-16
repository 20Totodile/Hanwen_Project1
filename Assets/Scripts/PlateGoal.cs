using UnityEngine;

/// <summary>
/// 以玩家可操作的 YZ 平面判断肉块是否位于盘子上方，成功后让肉块落进盘子。
/// </summary>
[RequireComponent(typeof(Renderer))]
public class PlateGoal : MonoBehaviour
{
    [SerializeField, Range(0.1f, 1f)] private float usableWidth = 0.85f;
    [SerializeField, Min(0f)] private float allowedHeightAbovePlate = 1.5f;
    [SerializeField, Min(0f)] private float dropClearance = 0.08f;

    private Renderer plateRenderer;
    private bool completed;

    private void Awake()
    {
        plateRenderer = GetComponent<Renderer>();
    }

    public bool TryPlace(SkewerableMeat meat)
    {
        if (completed || meat == null) return false;

        Bounds plateBounds = plateRenderer.bounds;
        Bounds meatBounds = meat.WorldBounds;

        // 当前玩法锁定 X，所以用画面中的 Z 位置和 Y 高度判断是否放到盘子上方。
        float halfUsableZ = plateBounds.extents.z * usableWidth;
        bool insideWidth = Mathf.Abs(meatBounds.center.z - plateBounds.center.z) <= halfUsableZ;
        bool nearPlateHeight =
            meatBounds.min.y >= plateBounds.min.y - 0.2f &&
            meatBounds.min.y <= plateBounds.max.y + allowedHeightAbovePlate;

        if (!insideWidth || !nearPlateHeight) return false;

        Vector3 dropPosition = meat.transform.position;
        dropPosition.x = plateBounds.center.x;
        dropPosition.z = Mathf.Clamp(
            dropPosition.z,
            plateBounds.center.z - halfUsableZ,
            plateBounds.center.z + halfUsableZ
        );
        dropPosition.y = plateBounds.max.y + meatBounds.extents.y + dropClearance;

        meat.SettleOnPlate(dropPosition);
        completed = true;
        Debug.Log("放置成功：肉块与签子保持连接并固定在盘中。", this);
        return true;
    }
}
