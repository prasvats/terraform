[
    {
        "portMappings": [
        {
            "containerPort": ${app_port}
        }
        ],
        "name": "${name}",
        "image": "${image}",
        "cpu": ${cpu},
        "memoryReservation": ${memory},
        "essential": true,
        "logConfiguration": {
                    "logDriver": "awslogs",
                    "options": {
                        "awslogs-region" : "${region}",
                        "awslogs-group" : "${envname}",
                        "awslogs-stream-prefix" : "ecs"
                    }
        }
    }
]