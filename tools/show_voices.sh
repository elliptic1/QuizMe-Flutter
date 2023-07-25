#!/bin/zsh

curl -H "xi-api-key: 50c93ca3075f939fe0c44b4ce03bf8c3" https://api.elevenlabs.io/v1/voices | jq '.voices[] | {voice_id, name}'

