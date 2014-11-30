using UnityEngine;
using System.Collections;

public class MenuCredits : Menu
{
   void OnMouseDown()
   {
      Application.LoadLevel("Credits");
   }
}
