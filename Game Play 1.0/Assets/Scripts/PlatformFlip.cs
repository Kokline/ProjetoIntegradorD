using UnityEngine;
using System.Collections;

public class PlatformFlip : MonoBehaviour
{

   private float tCycle;

   void Update()
   {
      var t = Time.time;

      if (tCycle - t <= 1)
      {
         transform.Rotate(0, 0, 180 * Time.deltaTime);
      }

      if (t > tCycle)
      {
         tCycle = t + 3;
         if (transform.localEulerAngles.z < 90)
         {
            float z = 0;
            Quaternion localRotation = this.transform.localRotation;
            Vector3 eulerAngles = localRotation.eulerAngles;
            eulerAngles.z = z;
            localRotation.eulerAngles = eulerAngles;
            this.transform.localRotation = localRotation;
         }
         else
         {
            float z = 180;
            Quaternion localRotation = this.transform.localRotation;
            Vector3 eulerAngles = localRotation.eulerAngles;
            eulerAngles.z = z;
            localRotation.eulerAngles = eulerAngles;
            this.transform.localRotation = localRotation;
         }
      }
   }
}
