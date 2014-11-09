using UnityEngine;
using System.Collections;

/// <summary>
/// Controle do jogador
/// </summary>
[RequireComponent(typeof(PlayerPhysics))]
public class PlayerController : Entity
{
   // Player Handling
   public float gravity = 20;
   public float walkSpeed = 8;
   public float runSpeed = 12;
   public float acceleration = 30;
   public float jumpHeight = 12;

   private float initiateSlideThreshold = 9;

   // System
   private float animationSpeed;
   private float currentSpeed;
   private float targetSpeed;
   private Vector2 amountToMove;
   private float moveDirX;

   // States
   private bool jumping;
   private bool ducking;

   // Components
   private PlayerPhysics playerPhysics;
   private Animator animator;
   private GameManager manager;

   /// <summary>
   /// Inicia o jogador
   /// </summary>
   void Start()
   {
      playerPhysics = GetComponent<PlayerPhysics>();
      animator = GetComponent<Animator>();
      manager = Camera.main.GetComponent<GameManager>();
      animator.SetLayerWeight(0, 0);
   }

   /// <summary>
   /// Atualiza todas as ações do jogador
   /// </summary>
   void Update()
   {
      ResetAcceleration();

      // Se o jogador estiver no chão
      if (playerPhysics.grounded)
      {
         amountToMove.y = 0;

         // Jump logic
         if (jumping)
         {
            jumping = false;
            animator.SetBool("Jumping", false);
         }
      }

      // Jump Input
      if (Input.GetButtonDown("Jump"))
      {
         Jump();
      }

      // Duck Input
      if (Input.GetButton("Duck"))
      {
         ducking = true;
         animator.SetBool("Ducking", true);
         playerPhysics.SetCollider(new Vector3(10.3f, 1.5f, 2.63f), new Vector3(.35f, 1f, 0f));
      }
      else
      {
         ducking = false;
         animator.SetBool("Ducking", false);
         playerPhysics.ResetCollider();
      }

      // Parâmetros de animação
      animationSpeed = IncrementTowards(animationSpeed, Mathf.Abs(targetSpeed), acceleration);
      animator.SetFloat("Speed", animationSpeed);

      MovimentacaoLateral();

      AmountToMove();

   }

   /// <summary>
   /// Move o personagem para os lados
   /// </summary>
   private void MovimentacaoLateral()
   {
      // Input
      moveDirX = Input.GetAxisRaw("Horizontal");
      float speed = (Input.GetButton("Run")) ? runSpeed : walkSpeed;
      targetSpeed = moveDirX * speed;
      currentSpeed = IncrementTowards(currentSpeed, targetSpeed, acceleration);

      // Face Direction
      if (moveDirX != 0)
      {
         transform.eulerAngles = (moveDirX > 0) ? Vector3.up * 180 : Vector3.zero;
      }
   }

   /// <summary>
   /// Pular
   /// </summary>
   private void Jump()
   {
      if (playerPhysics.grounded)
      {
         amountToMove.y = jumpHeight;
         jumping = true;
         animator.SetBool("Jumping", true);
      }
   }

   /// <summary>
   /// Reseta a aceleração quando há colisão
   /// </summary>
   private void ResetAcceleration()
   {
      if (playerPhysics.movementStopped)
      {
         targetSpeed = 0;
         currentSpeed = 0;
      }
   }

   /// <summary>
   /// Define o quanto o personagem se moverá
   /// </summary>
   private void AmountToMove()
   {
      amountToMove.x = currentSpeed;
      amountToMove.y -= gravity * Time.deltaTime;
      playerPhysics.Move(amountToMove * Time.deltaTime, moveDirX);
   }

   /// <summary>
   /// Verifica a colisão do jogador com os checkpoints e o fim do level
   /// </summary>
   /// <param name="collider"></param>
   void OnTriggerEnter(Collider collider)
   {
      if (collider.tag == "Checkpoint")
      {
         manager.SetCheckpoint(collider.transform.position);
      }
      if (collider.tag == "Finish")
      {
         manager.EndLevel();
      }
   }

   /// <summary>
   /// Incrementa a posição do jogador para que a movimentação seja feita
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
         float dir = Mathf.Sign(target - currentPosition); // must n be increased or decreased to get closer to target
         currentPosition += acceleration * Time.deltaTime * dir;
         return (dir == Mathf.Sign(target - currentPosition)) ? currentPosition : target; // if n has now passed target then return target, otherwise return n
      }
   }
}
