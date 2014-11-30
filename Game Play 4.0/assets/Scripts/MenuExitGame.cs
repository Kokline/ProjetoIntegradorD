using UnityEngine;
using System.Collections;

public class MenuExitGame : Menu
{
   void OnMouseDown()
   {
      Application.Quit();
   }
}
