using UnityEngine;
using System.Collections;

/// <summary>
/// Serra
/// </summary>
public class Sawblade : MonoBehaviour
{
   public float speed = 300;

   /// <summary>
   /// Gira a serra
   /// </summary>
   void Update()
   {
      transform.Rotate(Vector3.forward * speed * Time.deltaTime, Space.World);
   }

   /// <summary>
   /// Colisão da serra com o player
   /// </summary>
   /// <param name="collider"></param>
   void OnTriggerEnter(Collider collider)
   {
      if (collider.tag == "Player")
      {
         collider.GetComponent<Entity>().TakeDamage(10);
      }
   }
}
