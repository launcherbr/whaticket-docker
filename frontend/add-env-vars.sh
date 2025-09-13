#!/bin/sh

_replaceFrontendEnvVars() {
    echo "Buscando arquivos com valores para alterar..."
    # Debug - mostrar valores das variaveis
    echo "DEBUG: REACT_APP_BACKEND_URL=$REACT_APP_BACKEND_URL"
    echo "DEBUG: REACT_APP_HOURS_CLOSE_TICKETS_AUTO=$REACT_APP_HOURS_CLOSE_TICKETS_AUTO"

    # [cite_start]Verificar se o diretorio existe [cite: 4]
    if [ ! -d "/usr/src/app/build" ]; then
        echo "ERRO: Pasta /usr/src/app/build inexistente"
        exit 1
    fi

    # [cite_start]Encontra todos os arquivos que contem as variaveis ou URLs especificas [cite: 5]
    FILES=$(grep -rl "hours_ticket_close_auto\|https://api.example.com" /usr/src/app/build)

    if [ -z "$FILES" ]; then
        [cite_start]echo "Nenhum arquivo contendo as registros exatos encontrado." [cite: 6]
        exit 1
    fi

    for FILE in $FILES; do
        [cite_start]echo "Modificando $FILE..." [cite: 8]

        # [cite_start]Escapar caracteres especiais nas variaveis de ambiente [cite: 8]
        ESCAPED_REACT_APP_HOURS_CLOSE_TICKETS_AUTO=$(printf '%s\n' "$REACT_APP_HOURS_CLOSE_TICKETS_AUTO" | sed 's:[\\/&]:\\&:g')
        ESCAPED_REACT_APP_BACKEND_URL=$(printf '%s\n' "$REACT_APP_BACKEND_URL" | sed 's:[\\/&]:\\&:g')

        # [cite_start]Substituir as variaveis e URLs nos arquivos [cite: 8]
        sed -i "s/hours_ticket_close_auto/${ESCAPED_REACT_APP_HOURS_CLOSE_TICKETS_AUTO}/g" "$FILE"
        sed -i "s|https://api.example.com|${ESCAPED_REACT_APP_BACKEND_URL}|g" "$FILE"

        [cite_start]echo "$FILE modificado com sucesso." [cite: 9]
    done
}

_replaceFrontendEnvVars