using UnityEngine;
using System.Collections;

public class MenuPlayGame : Menu
{
   public GameManager gameManager;

   void OnMouseDown()
   {
      gameManager.StartGame();
   }
}
