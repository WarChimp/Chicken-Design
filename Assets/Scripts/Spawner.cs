using UnityEngine;
using System.Collections;

public class Spawner : MonoBehaviour
{

    public GameObject[] eggSpawn;
    public Vector3 spawnValues;
    public float spawnWait; // this is for time - not necessary at the moment. We are splitting them into days
    public float spawnMostWait;
    public float spawnLeastWait;

    int randEnemy;

    // Use this for initialization
    void Start()
    {
        StartCoroutine(Spawn());
    }

    // Update is called once per frame
    void Update()
    {
        spawnWait = Random.Range(spawnLeastWait, spawnMostWait);
    }

    //code routine - spawn over and over agian
    IEnumerator Spawn()
    {
        yield return new WaitForSeconds(spawnWait);


        //amount of chickens?? Will need to think
        while (true)
        {
            randEnemy = Random.Range(0, 2); //this is going to decide which object it's going to pick. Will need to re-think this

            Vector3 spawnPosition = new Vector3(Random.Range(-spawnValues.x, spawnValues.x), 1, (Random.Range(-spawnValues.z, spawnValues.z)));

            Instantiate(eggSpawn[0], spawnPosition + transform.TransformPoint(0, 0, 0), gameObject.transform.rotation);

            yield return new WaitForSeconds(spawnWait);
        }
    }

}