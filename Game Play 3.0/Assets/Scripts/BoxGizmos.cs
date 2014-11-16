using UnityEngine;
using System.Collections;

/// <summary>
/// Desenho de objetos abstratos
/// </summary>
[RequireComponent(typeof(BoxCollider))]
public class BoxGizmos : MonoBehaviour
{
   public Color gizmoColour;

   /// <summary>
   /// Representação visual dos checkpoints, spawn point e fim do level
   /// </summary>
   void OnDrawGizmos()
   {
      Gizmos.color = gizmoColour;
      Gizmos.DrawCube(transform.position + GetComponent<BoxCollider>().center, GetComponent<BoxCollider>().size);
   }
}