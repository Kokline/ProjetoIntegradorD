using UnityEngine;
using System.Collections;

public class MenuPlayGame : Menu
{
   void OnMouseDown()
   {
      Application.LoadLevel("GamePlay");
   }
}
