# _shell
_shell()
{
    if [ -f "${GITHUBSH_HISTORY}" ]; then
        history -r "${GITHUBSH_HISTORY}"
    else
        touch "${GITHUBSH_HISTORY}"
    fi

    _echo "[32]Welcome to Github Shell[0] - [34]${GITHUBSH_VERSION}[0]" ""

    history -r "${GITHUBSH_HISTORY}"

    while read -e -p "${GITHUB_PROMPT}" input; do

        if [ "${input}" == "" ]; then
            continue
        fi

        command_name=$(echo "${input}" | awk '{print $1}')
        if [ "$(echo "${input}" | wc -w | awk '{print $1}')" != 1 ]; then
            command_args=$(echo "${input}" | cut -d ' ' -f 2-)
        else
            command_args=""
        fi

		history -s "${input}"

        case "${command_name}" in

            set | issue | exit | help | reload)
                _action_${command_name} ${command_args}
            ;;

            *)
                _echo -e "[31]Command \"${command_name}\" not found.[0]"
                continue
            ;;

        esac

        history -w "${GITHUBSH_HISTORY}"

    done

}
