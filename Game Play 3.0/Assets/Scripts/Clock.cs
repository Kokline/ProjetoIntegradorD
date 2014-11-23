using UnityEngine;
using System.Collections;

public class Clock : MonoBehaviour
{

   public GameManager gameCamera;

   // Use this for initialization
   void Start()
   {

   }

   // Update is called once per frame
   void Update()
   {

   }

   /// <summary>
   /// Colisão da serra com o player
   /// </summary>
   /// <param name="collider"></param>
   void OnTriggerEnter(Collider collider)
   {
      if (collider.tag == "Player")
      {
         gameCamera.IncreaseTime();
         Destroy(this.gameObject);
      }
   }
}
