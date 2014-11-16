using UnityEngine;
using System.Collections;
using System.Collections.Generic;

/// <summary>
/// Ragdoll
/// </summary>
public class Ragdoll : MonoBehaviour
{
   private List<Transform> poseBones = new List<Transform>();
   private List<Transform> ragdollBones = new List<Transform>();

   /// <summary>
   /// Copia a pose atual do player para o ragdoll
   /// </summary>
   /// <param name="pose"></param>
   public void CopyPose(Transform pose)
   {
      AddChildren(pose, poseBones);
      AddChildren(transform, ragdollBones);

      foreach (Transform b in poseBones)
      {
         foreach (Transform r in ragdollBones)
         {
            if (r.name == b.name)
            {
               r.eulerAngles = b.eulerAngles;
               break;
            }
         }
      }
   }

   /// <summary>
   /// Adiciona os bones do ragdoll na mesma posição dos bones do player
   /// </summary>
   /// <param name="parent"></param>
   /// <param name="list"></param>
   private void AddChildren(Transform parent, List<Transform> list)
   {
      list.Add(parent);
      foreach (Transform t in parent)
      {
         AddChildren(t, list);
      }
   }
}
