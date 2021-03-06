﻿using UnityEngine;
using System.Collections;

public class ChickenAI : MonoBehaviour {

    public float moveSpeed;

    private Rigidbody myRigidbody;

    private bool moving;

    public float timeBetweenMove;
    private float timeBetweenMoveCounter;
    public float timeToMove;
    private float timeToMoveCounter;

    private Vector3 moveDirection;

	// Use this for initialization
	void Start () {

        myRigidbody = GetComponent<Rigidbody>();

        timeBetweenMoveCounter = timeBetweenMove;
        timeToMoveCounter = timeToMove;

	}
	
	// Update is called once per frame
	void Update () {

        if (moving)
        {

            timeToMoveCounter -= Time.deltaTime;
            myRigidbody.velocity = moveDirection;

            if (timeToMoveCounter < 0f)
            {
                moving = false;
                timeBetweenMoveCounter = timeBetweenMove;
            }

        }
        else
        {
            timeBetweenMoveCounter -= Time.deltaTime;

            myRigidbody.velocity = Vector3.zero;

            if(timeBetweenMoveCounter < 0f)
            {
                moving = true;
                timeToMoveCounter = timeToMove;

                moveDirection = new Vector3(Random.Range(-1f, 1f) * moveSpeed, 0,(Random.Range(-1f, 1f) * moveSpeed));
            }
        }
        

	}
}
