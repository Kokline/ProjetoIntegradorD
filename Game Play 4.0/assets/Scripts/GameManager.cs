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
   private float time = 60;
   private float minutes = 0;
   private float seconds = 0;
   public GUIText timer;
   private bool gameOver = false;

  
   /// Inicia a camera e ponto de inicio do jogo
   /// </summary>
   public void Start()
   {
      StartCoroutine(Timer());
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
      minutes = Mathf.FloorToInt(time / 60F);
      seconds = Mathf.FloorToInt(time - minutes * 60);

      if (!currentPlayer && !gameOver)
      {
         if (Input.GetButtonDown("Respawn"))
         {
            SpawnPlayer(checkpoint);
         }
      }
   }

   public void IncreaseTime()
   {
      time += 20;
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

   /// <summary>
   /// Timer
   /// </summary>
   /// <returns></returns>
   IEnumerator Timer()
   {
      timer.text = time.ToString();
      while (time > 0)
      {
         timer.text = string.Format("{0:0}:{1:00}", minutes, seconds);
         time -= 1;
         yield return new WaitForSeconds(1);
      }

      GameObject.FindGameObjectWithTag("Player").GetComponent<Entity>().TakeDamage(10);
      timer.text = "Game Over";
      gameOver = true;
      Application.LoadLevel("GameOver");
   }
}
