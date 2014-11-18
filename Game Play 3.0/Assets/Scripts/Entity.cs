using UnityEngine;
using System.Collections;

/// <summary>
/// Entidades do jogo
/// </summary>
public class Entity : MonoBehaviour
{
   public float health;
   public GameObject ragdoll;

   /// <summary>
   /// Recebe dano
   /// </summary>
   /// <param name="dmg"></param>
   public void TakeDamage(float dmg)
   {
      health -= dmg;
      if (health <= 0)
      {
         Die();
      }
   }

   /// <summary>
   /// Morre
   /// </summary>
   public void Die()
   {
      Ragdoll deadPlayer = (Instantiate(ragdoll, transform.position, transform.rotation) as GameObject).GetComponent<Ragdoll>();
      deadPlayer.CopyPose(transform);
      Destroy(this.gameObject);
   }
}