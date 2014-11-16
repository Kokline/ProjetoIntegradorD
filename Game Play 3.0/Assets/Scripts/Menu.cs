using UnityEngine;
using System.Collections;

public class Menu : MonoBehaviour
{
   public GameCamera cam;

   void OnMouseEnter()
   {
      cam.SetZoom(true, transform);
   }

   void OnMouseExit()
   {
      cam.SetZoom(false, null);
   }
}
