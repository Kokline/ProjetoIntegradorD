using UnityEngine;
using System.Collections;

/// <summary>
/// Comportamento da camera
/// </summary>
public class GameCamera : MonoBehaviour
{
   private Transform target;
   public float trackSpeed = 25;

   /// <summary>
   /// Define o alvo da camera
   public void SetTarget(Transform t)
   {
      target = t;
      transform.position = new Vector3(target.position.x + 5, target.position.y + 2, transform.position.z);
      transform.rotation = Quaternion.Euler(7, -32, -2);
   }

   /// <summary>
   /// Segue os movimentos do personagem
   /// </summary>
   void LateUpdate()
   {
      if (target)
      {
         float x = IncrementTowards(transform.position.x, target.position.x + 5, trackSpeed);
         float y = IncrementTowards(transform.position.y, target.position.y + 2, trackSpeed);
         transform.position = new Vector3(x, y, transform.position.z);
      }
   }

   /// <summary>
   /// Incrementa a posição da camera para seguir o personagem
   private float IncrementTowards(float currentPosition, float target, float acceleration)
   {
      if (currentPosition == target)
      {
         return currentPosition;
      }
      else
      {
         float direction = Mathf.Sign(target - currentPosition); // must n be increased or decreased to get closer to target
         currentPosition += acceleration * Time.deltaTime * direction;
         return (direction == Mathf.Sign(target - currentPosition)) ? currentPosition : target; // if n has now passed target then return target, otherwise return n
      }
   }
}
