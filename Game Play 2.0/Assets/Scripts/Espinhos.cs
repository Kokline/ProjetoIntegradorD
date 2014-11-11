using UnityEngine;
using System.Collections;

/// <summary>
/// Serra
/// </summary>
public class Espinhos : MonoBehaviour
{
   /// <summary>
   /// Colisão da serra com o player
   /// </summary>
   /// <param name="collider"></param>
   void OnTriggerEnter(Collider collider)
   {
      //Debug.Log("Ouch");
      if (collider.tag == "Player")
      {
         collider.GetComponent<Entity>().TakeDamage(10);
      }
   }
}
