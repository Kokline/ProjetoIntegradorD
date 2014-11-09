using UnityEngine;
using System.Collections;

/// <summary>
/// Manager do jogo
/// </summary>
public class GameManager : MonoBehaviour
{
   public GameObject player;
   private GameObject currentPlayer;
   private GameCamera cam;
   private Vector3 checkpoint;

   public static int levelCount = 2;
   public static int currentLevel = 1;

   /// <summary>
   /// Inicia a camera e ponto de inicio do jogo
   /// </summary>
   void Start()
   {
      cam = GetComponent<GameCamera>();

      if (GameObject.FindGameObjectWithTag("Spawn"))
      {
         checkpoint = GameObject.FindGameObjectWithTag("Spawn").transform.position;
      }

      SpawnPlayer(checkpoint);
   }

   /// <summary>
   /// Instancia o jogador
   /// </summary>
   /// <param name="spawnPos"></param>
   private void SpawnPlayer(Vector3 spawnPos)
   {
       currentPlayer = Instantiate(player, spawnPos, Quaternion.Euler(0, 90, 0)) as GameObject;
       cam.SetTarget(currentPlayer.transform);
   }

   /// <summary>
   /// Botão para respawn
   /// </summary>
   private void Update()
   {
      if (!currentPlayer)
      {
         if (Input.GetButtonDown("Respawn"))
         {
            SpawnPlayer(checkpoint);
         }
      }
   }

   /// <summary>
   /// Define os checkpoints
   /// </summary>
   /// <param name="cp"></param>
   public void SetCheckpoint(Vector3 cp)
   {
      checkpoint = cp;
   }

   /// <summary>
   /// Define o fim do jogo ou carrega o próximo level
   /// </summary>
   public void EndLevel()
   {
      if (currentLevel < levelCount)
      {
         currentLevel++;
         Application.LoadLevel("Level " + currentLevel);
      }
      else
      {
         Debug.Log("Game Over");
      }
   }
}
