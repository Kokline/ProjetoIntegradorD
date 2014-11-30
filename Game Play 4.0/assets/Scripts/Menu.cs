using UnityEngine;
using System.Collections;

public class Menu : MonoBehaviour
{
   public GameCameraMenu cam;

   void OnMouseEnter()
   {
      cam.SetZoom(true, this.transform);
   }

   void OnMouseExit()
   {
      cam.SetZoom(false, null);
   }

}
