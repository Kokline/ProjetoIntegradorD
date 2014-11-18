using UnityEngine;
using System.Collections;

/// <summary>
/// Plataforma móvel
/// </summary>
public class PlatformHorizontal : MonoBehaviour
{
   /// <summary>
   /// Velocidade da plataforma movel
   /// </summary>
   public float speed = 2;

   public Vector2 startPosition;

   void Start()
   {
      startPosition = transform.position;
   }

   /// <summary>
   /// Movimentação da plataforma movel
   /// </summary>
   virtual public void Update()
   {
      if (this.transform.position.x >= startPosition.x)
      {
         speed *= -1;
      }
      else if (this.transform.position.x <= startPosition.x - 5)
      {
         speed *= -1;
      }
      transform.Translate(Vector3.right * speed * Time.deltaTime);
   }
}
