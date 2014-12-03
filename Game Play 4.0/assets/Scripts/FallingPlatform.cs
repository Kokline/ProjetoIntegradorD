using UnityEngine;
using System.Collections;

public class FallingPlatform : MonoBehaviour
{
   bool isFalling = false;
   float downSpeed = 0;

   void HitByRay ()
   {
      isFalling = true;
      Destroy(gameObject, 10);
   }

   void Update()
   {
      if (isFalling)
      {
         downSpeed += Time.deltaTime / 10;
         transform.position = new Vector3(transform.position.x, transform.position.y - downSpeed, transform.position.z);
      }
   }

}
