using UnityEngine;
using System.Collections;

/// <summary>
/// Fisica do player
/// </summary>
[RequireComponent(typeof(BoxCollider))]
public class PlayerPhysics : MonoBehaviour
{
   public LayerMask collisionMask;

   private BoxCollider collider;
   private Vector3 size;
   private Vector3 center;

   private Vector3 originalSize;
   private Vector3 originalCentre;
   private float colliderScale;

   private int collisionDivisionsX = 3;
   private int collisionDivisionsY = 10;

   private float skinVertical = 1.5f;
   private float skinHorizontal = .005f;

   [HideInInspector]
   public bool grounded;
   [HideInInspector]
   public bool movementStopped;

   private Transform platform;
   private Vector3 platformPositionOld;
   private Vector3 deltaPlatformPos;

   Ray ray;
   RaycastHit hit;

   void Start()
   {
      collider = GetComponent<BoxCollider>();
      colliderScale = transform.localScale.x;

      originalSize = collider.size;
      originalCentre = collider.center;
      SetCollider(originalSize, originalCentre);
   }

   /// <summary>
   /// Movimentação
   /// </summary>
   /// <param name="moveAmount"></param>
   /// <param name="moveDirX"></param>
   public void Move(Vector2 moveAmount, float moveDirX)
   {
      float deltaY = moveAmount.y;
      float deltaX = moveAmount.x;
      Vector2 position = transform.position;

      if (platform)
      {
         deltaPlatformPos = platform.position - platformPositionOld;
      }
      else
      {
         deltaPlatformPos = Vector3.zero;
      }

      ColisoesVerticais(ref deltaY, ref position);
      ColisoesHorizontais(ref deltaX, ref position);

      if (!grounded && !movementStopped)
      {
         Vector3 playerDir = new Vector3(deltaX, deltaY);
         Vector3 o = new Vector3(position.x + center.x + size.x / 2 * Mathf.Sign(deltaX), position.y + center.y + size.y / 2 * Mathf.Sign(deltaY));
         ray = new Ray(o, playerDir.normalized);

         if (Physics.Raycast(ray, Mathf.Sqrt(deltaX * deltaX + deltaY * deltaY), collisionMask))
         {
            grounded = true;
            deltaY = 0;
         }
      }

      Vector2 finalTransform = new Vector2(deltaX + deltaPlatformPos.x, deltaY + deltaPlatformPos.y);
      transform.Translate(finalTransform, Space.World);
   }

   /// <summary>
   /// Verifica colisões dos lados
   /// </summary>
   /// <param name="deltaY"></param>
   /// <param name="position"></param>
   private void ColisoesVerticais(ref float deltaY, ref Vector2 position)
   {
      grounded = false;

      for (int i = 0; i < collisionDivisionsX; i++)
      {
         float direction = Mathf.Sign(deltaY);
         float x = (position.x + center.x - size.x / 2) + size.x / (collisionDivisionsX - 1) * i; // Esquerda, centro e direita do collider
         float y = position.y + center.y + size.y / 2 * direction; // Parte de baixo do collider

         ray = new Ray(new Vector2(x, y), new Vector2(0, direction));
         Debug.DrawRay(ray.origin, ray.direction);

         if (Physics.Raycast(ray, out hit, Mathf.Abs(deltaY) + skinVertical, collisionMask))
         {
            platform = hit.transform;
            platformPositionOld = platform.position;

            // Distancia entre o player e o chao
            float distance = Vector3.Distance(ray.origin, hit.point);

            // Para o movimento de queda do player quando há o contato com algum piso
            if (distance > skinVertical)
            {
               deltaY = distance * direction - skinVertical * direction;
            }
            else
            {
               deltaY = 0;
            }
            grounded = true;
            break;
         }
         else
         {
            platform = null;
         }
      }
   }

   /// <summary>
   /// Verifica colisões acima e embaixo
   /// </summary>
   /// <param name="deltaX"></param>
   /// <param name="position"></param>
   private void ColisoesHorizontais(ref float deltaX, ref Vector2 position)
   {
      movementStopped = false;

      if (deltaX != 0)
      {
         for (int i = 0; i < collisionDivisionsY; i++)
         {
            float direction = Mathf.Sign(deltaX);
            float x = position.x + center.x + size.x / 2 * direction;
            float y = position.y + center.y - size.y / 2 + size.y / (collisionDivisionsY - 1) * i;

            ray = new Ray(new Vector2(x, y), new Vector2(direction, 0));
            Debug.DrawRay(ray.origin, ray.direction);

            if (Physics.Raycast(ray, out hit, Mathf.Abs(deltaX) + skinHorizontal, collisionMask))
            {
               // Distancia entre o player e o chao
               float distance = Vector3.Distance(ray.origin, hit.point);

               // Para o movimento de queda do player quando há o contato com algum piso
               if (distance > skinHorizontal)
               {
                  deltaX = distance * direction - skinHorizontal * direction;
               }
               else
               {
                  deltaX = 0;
               }

               movementStopped = true;
               break;
            }
         }
      }
   }

   /// <summary>
   /// Define o collider
   /// </summary>
   /// <param name="size"></param>
   /// <param name="centre"></param>
   public void SetCollider(Vector3 size, Vector3 centre)
   {
      collider.size = size;
      collider.center = centre;

      size = size * colliderScale;
      center = centre * colliderScale;
   }

   /// <summary>
   /// Reseta o collider
   /// </summary>
   public void ResetCollider()
   {
      SetCollider(originalSize, originalCentre);
   }

}
