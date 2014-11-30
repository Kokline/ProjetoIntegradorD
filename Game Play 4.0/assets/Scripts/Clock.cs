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

   /// Colisão da serra com o player
   void OnTriggerEnter(Collider collider)
   {
      if (collider.tag == "Player")
      {
         gameCamera.IncreaseTime();
         Destroy(this.gameObject);
      }
   }
}
