using UnityEngine;
using System.Collections;

/// <summary>
/// Plataforma móvel
/// </summary>
public class PlatformVertical : MonoBehaviour
{
   /// <summary>
   /// Velocidade da plataforma movel
   /// </summary>
   public float speed = 2;

   private Vector2 startPosition;
   private bool turnOn = false;

   void Start()
   {
      startPosition = transform.position;
   }

   /// <summary>
   /// Movimentação da plataforma movel
   /// </summary>
   void Update()
   {
      if (turnOn)
      {
         transform.Translate(Vector3.up * speed * Time.deltaTime);
      }
      else
      {
         if (transform.position.y >= startPosition.y)
         {
            transform.Translate(Vector3.up * -speed * Time.deltaTime);
         }
      }
   }

   /// <summary>
   /// Início de colisão
   /// </summary>
   /// <param name="collider"></param>
   void OnTriggerEnter(Collider collider)
   {
      if (collider.tag == "Player")
      {
         turnOn = true;
      }
   }

   /// <summary>
   /// Fim de colisão
   /// </summary>
   /// <param name="collider"></param>
   void OnTriggerExit(Collider collider)
   {
      if (collider.tag == "Player")
      {
         turnOn = false;
      }
   }
}
