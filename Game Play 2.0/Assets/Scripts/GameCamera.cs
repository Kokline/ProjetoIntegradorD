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
   /// </summary>
   /// <param name="t"></param>
   public void SetTarget(Transform t)
   {
      target = t;
      transform.position = new Vector3(t.position.x + 10, t.position.y + 5, transform.position.z);
   }

   /// <summary>
   /// Segue os movimentos do personagem
   /// </summary>
   void LateUpdate()
   {
      if (target)
      {
         float x = IncrementTowards(transform.position.x, target.position.x + 10, trackSpeed);
         float y = IncrementTowards(transform.position.y, target.position.y + 5, trackSpeed);
         transform.position = new Vector3(x, y, transform.position.z);
      }
   }

   /// <summary>
   /// Incrementa a posição da camera para seguir o personagem
   /// </summary>
   /// <param name="currentPosition"></param>
   /// <param name="target"></param>
   /// <param name="acceleration"></param>
   /// <returns></returns>
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
