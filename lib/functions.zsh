function zsh_stats() {
  history | awk '{print $2}' | sort | uniq -c | sort -rn | head
}

function uninstall_oh_my_zsh() {
  /usr/bin/env ZSH=$ZSH /bin/sh $ZSH/tools/uninstall.sh
}

function upgrade_oh_my_zsh() {
  /usr/bin/env ZSH=$ZSH /bin/sh $ZSH/tools/upgrade.sh
}

function take() {
  mkdir -p $1
  cd $1
}

function sshr() {
    storage=`echo $1 |grep -v 'mdst' |grep -v mds.nebiuscore.net |grep -P '^s\d+\w+'`
    if [ -z $storage ]
    then
        ssh -A -l root $*
    else
        ssh -A -l kanst9 $*
    fi
}

function vpndown() {
  sudo kill `cat /var/run/openvpn.pid`
}

function hwclear() {
  ssh root@$1 rm -f /home/monitor/agents/tmp/mulca_hw_errors.msg.prev 2>/dev/null
}

function deb() {
  if [ -z $1 ] 
  then
    debuild && debrelease && debclean&& debcommit -a;
  else
    debuild && debrelease -t $1 && debclean&& debcommit -a
  fi
}

j () {
  local OLDIFS=$IFS
  IFS=${1:?"Missing separator"} 
  shift
  echo "$*"
  IFS=$OLDIFS 
}


function vimr() {
    export LC_ALL=C
    n=`echo $1 | awk -F "/" '{print $NF}' | grep -P "^\d+" -o`
    echo "start `date`" >> ~/yandex_disk/Documents/code/rebrain/time-$n
    vim $1
    echo "finish `date`" >> ~/yandex_disk/Documents/code/rebrain/time-$n
}

function ipmi_max() {
    IPMIPROXY_API_URL="https://ipmiproxy.max.einebox.net/ipmiproxy/api/v1.0" IPMIPROXY_LOGIN=kanst9  IPMIPROXY_PASSWORD=tool1phee7maa6Ed yaipmi -H $1 ${@:2}
}

function ipmi_il() {
    IPMIPROXY_API_URL="https://ipmiproxy.is.einebox.net/ipmiproxy/api/v1.0" IPMIPROXY_LOGIN=kanst9  IPMIPROXY_PASSWORD=tool1phee7maa6Ed yaipmi -H $1 ${@:2}
}

mdsp() {
  ya tool mds --profile prod "$@"
}
mdspre() {
  ya tool mds --profile prestable "$@"
}
mdst() {
  ya tool mds --profile testing "$@"
}
compdef _mds mdsp
compdef _mds mdspre
compdef _mds mdst

if (( $+aliases[rebase] )); then
  unalias rebase
fi

function rebase {
  arc pull trunk || return $?
  arc rebase --onto trunk "$@" || return $?

  local rebase_root
  rebase_root=$(arc root) || return $?
  [[ -f "$rebase_root/mds/.agents/plugins/marketplace.json" ]] || return 0

  python3 - "$rebase_root/mds" <<'PY'
import json
import shutil
import subprocess
import sys
from pathlib import Path

project = Path(sys.argv[1]).resolve()
failed = False
updated = 0


def read_json(*args):
    return json.loads(subprocess.check_output(args, cwd=project, text=True))


def run(*args):
    print("rebase: " + " ".join(args), flush=True)
    subprocess.run(args, cwd=project, check=True)


def marketplace(sources, name):
    matches = [item for item in sources if item["name"] == name]
    if len(matches) != 1:
        raise ValueError(f"Marketplace missing or duplicated: {name}")
    return matches[0]


for client in ("codex", "claude"):
    if not shutil.which(client):
        continue
    try:
        if client == "codex":
            catalog = json.loads((project / ".agents/plugins/marketplace.json").read_text())
            market = catalog["name"]
            allowed = {p["name"] + "@" + market for p in catalog["plugins"]}
            installed = read_json("codex", "plugin", "list", "--marketplace", market, "--json")["installed"]
            commands = [("codex", "plugin", "add", p["pluginId"]) for p in installed
                        if p["pluginId"] in allowed and p["enabled"]]
            if not commands:
                continue
            sources = read_json("codex", "plugin", "marketplace", "list", "--json")["marketplaces"]
            source = marketplace(sources, market)
            if Path(source["root"]).resolve() != project:
                raise ValueError("Codex marketplace points at another checkout")
        else:
            catalog = json.loads((project / ".claude-plugin/marketplace.json").read_text())
            market = catalog["name"]
            allowed = {p["name"] + "@" + market for p in catalog["plugins"]}
            installed = read_json("claude", "plugin", "list", "--json")
            commands = [("claude", "plugin", "update", p["id"], "--scope", p["scope"]) for p in installed
                        if p["id"] in allowed and p["enabled"]
                        and p["scope"] in ("user", "project", "local")
                        and (p["scope"] == "user" or Path(p["projectPath"]).resolve() == project)]
            if not commands:
                continue
            sources = read_json("claude", "plugin", "marketplace", "list", "--json")
            source = marketplace(sources, market)
            location = Path(source["installLocation"]).resolve()
            if location == project / ".claude/marketplace":
                run("claude", "plugin", "marketplace", "add", str(project))
            elif location != project:
                raise ValueError("Claude marketplace points at another checkout")
            else:
                run("claude", "plugin", "marketplace", "update", market)
    except (subprocess.CalledProcessError, OSError, ValueError, KeyError) as error:
        print(f"rebase: {client}: {error}", file=sys.stderr)
        failed = True
        continue

    for args in commands:
        try:
            run(*args)
            updated += 1
        except (subprocess.CalledProcessError, OSError) as error:
            print(f"rebase: {client}: {error}", file=sys.stderr)
            failed = True

if updated:
    print(f"rebase: обновлено плагинов: {updated}. Перезапустите Codex/Claude, чтобы применить изменения.")
if failed:
    print("rebase: Arc успешно обновлён; обновление плагинов завершилось с ошибками.", file=sys.stderr)
    sys.exit(2)
PY
}
