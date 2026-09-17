using UnityEngine;

/// <summary>
/// 单击球体后，让球持续吸附并跟随鼠标。
/// </summary>
[RequireComponent(typeof(Collider))]
public class ClickToFollowMouse : MonoBehaviour
{
    private static ClickToFollowMouse activeBall;

    private Camera mainCamera;
    private Rigidbody body;
    private float cameraDepth;
    private bool isFollowing;

    private void Awake()
    {
        mainCamera = Camera.main;
        body = GetComponent<Rigidbody>();
    }

    private void OnMouseDown()
    {
        if (mainCamera == null) mainCamera = Camera.main;
        if (mainCamera == null) return;

        if (activeBall != null && activeBall != this)
            activeBall.StopFollowing();

        activeBall = this;
        isFollowing = true;
        cameraDepth = mainCamera.WorldToScreenPoint(transform.position).z;

        if (body != null)
        {
            body.velocity = Vector3.zero;
            body.angularVelocity = Vector3.zero;
            body.useGravity = false;
            body.isKinematic = true;
        }

        FollowMouse();
    }

    private void Update()
    {
        if (isFollowing) FollowMouse();
    }

    private void FollowMouse()
    {
        Vector3 mousePosition = Input.mousePosition;
        mousePosition.z = cameraDepth;
        transform.position = mainCamera.ScreenToWorldPoint(mousePosition);
    }

    private void StopFollowing()
    {
        isFollowing = false;

        if (body != null)
        {
            body.isKinematic = false;
            body.useGravity = true;
        }
    }
}
