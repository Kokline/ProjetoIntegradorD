using UnityEngine;
using System.Collections;

public class GameCameraMenu : MonoBehaviour
{

   private bool zoom;
   public Transform menu;

   public void Update()
   {
      if (zoom)
      {
         transform.position = Vector3.MoveTowards(transform.position, new Vector3(menu.position.x, menu.position.y + 0.05F, menu.position.z - 2.5F), 0.08F);
      }
      else
      {
         transform.position = Vector3.MoveTowards(transform.position, new Vector3(-0.12F, -4.9F, -1.87F), 0.05F);
      }
   }

   public void ZoomOnMenu(Transform t)
   {
      zoom = true;
   }

   public void SetZoom(bool zoomOnOff, Transform menuPosition)
   {
      zoom = zoomOnOff;
      menu = menuPosition;
   }

   public void ResetPosition()
   {
      zoom = false;
   }
}
