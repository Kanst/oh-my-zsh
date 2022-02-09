#compdef arc

_arc() {
  local state line desc modes context curcontext="$curcontext" ret=1
  local words_orig=("${words[@]}")
  local current_orig="$((CURRENT - 1))"
  local prefix_orig="$PREFIX"
  local suffix_orig="$SUFFIX"

  _arguments -C \
    '(- : *)'{-h,--help}'[show help information]' \
    '(- : *)'{-v,--version}'[display version information]' \
    '(- : *)--svnrevision[show build information]' \
    '(-v --version -h --help --svnrevision)1: :->modes' \
    '(-v --version -h --help --svnrevision)*:: :->args' \
    && ret=0

  case $state in
    modes)
      desc='modes'
      modes=(
      )

      desc='start a working area'
      modes=(
        'init':'Initialize environment for a local repository'
        'mount':'Initialize environment with virtual working tree'
        'unmount':'Close environment for a local repository'
        'sync':'Synchronize working copy with remote one'
      )
      _describe -t 'mode-group-1' $desc modes

      desc='work on the current change'
      modes=(
        'add':'Add file contents to the index'
        'clean':'Remove untracked files from the working tree'
        'cp':'Copy a file, a directory, or a symlink'
        'encrypt':'Encrypt file'
        'mergetool':'Run merge conflict resolution tools to resolve merge conflicts'
        'mv':'Move or rename a file, a directory, or a symlink'
        'reset':'Reset current HEAD to the specified state'
        'rm':'Remove files from the working tree and from the index'
        'stash':'Stash changes, list or apply existing stashes'
      )
      _describe -t 'mode-group-2' $desc modes

      desc='examine the history and state'
      modes=(
        'blame':'Show what revision and author last modified each line of a file'
        'praise':'Show what revision and author last modified each line of a file to praise them'
        'describe':'Describe a commit using the most recent tag reachable from it'
        'diff':'Show changes between commits, commit and working tree, etc'
        'difftool':'View diff using difftools'
        'ls-files':'Show information about files in the index and the working tree'
        'log':'Show commit logs'
        'reflog':'Show reflogs'
        'merge-base':'Show commits'' merge base'
        'root':'Show working tree root'
        'show':'Show various types of objects'
        'status':'Show the working tree status'
      )
      _describe -t 'mode-group-3' $desc modes

      desc='grow, mark and tweak your common history'
      modes=(
        'branch':'List, create, or delete branches'
        'checkout':'Switch branches or restore working tree files'
        'cherry-pick':'Apply the changes introduced by some existing commits'
        'commit':'Record changes to the repository'
        'rebase':'Forward-port local commits to the updated upstream head'
        'revert':'Revert some existing commits'
        'tag':'Create or list tags'
      )
      _describe -t 'mode-group-4' $desc modes

      desc='collaborate'
      modes=(
        'fetch':'Download refs from remote repository'
        'pr':'Create, discard, list or checkout pull-requests'
        'pull':'Fetch from remote repository and integrate with a local branch'
        'push':'Update remote refs along with associated objects'
      )
      _describe -t 'mode-group-5' $desc modes

      desc='verify, analyse and manage objects'
      modes=(
        'fsck':'Verifies the connectivity and validity of the objects in the database'
        'archive':'Create an archive of files from a named tree'
        'export':'Exports a named tree'
        'gc':'Cleanup object store'
      )
      _describe -t 'mode-group-6' $desc modes

      desc='internal operations'
      modes=(
        'config':'Manage user configuration'
        'dump':'Various debug information'
        'gen-key':'Generate new encryption key and store it in YAV'
        'info':'Show current branch information'
        'ls-tree':'List the contents of a tree object'
        'rev-parse':'Pick out and massage parameters'
        'token':'Acquire arc oauth token with ssh key'
        'prefetch-files':'Prefetch files'
        'repair-command'
        'list-commands':'List arc commands in JSON'
        'completion':'generate autocompletion files'
      )
      _describe -t 'mode-group-7' $desc modes

      ;;
    args)
      case $line[1] in
        'init')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(--server -s)'{'-s','--server'}'[adress of arc service]: :_default' \
            '(--port -p)'{'-p','--port'}'[port of arc data service]: :_default' \
            '(--ssl)--ssl[use ssl connection to server]: :_default' \
            '(-r --repository)'{'-r','--repository'}'[name of the repository]: :_default' \
            '(--bare)--bare[initialize bare repository]' \
            '(--object-store)--object-store[shared store for storing objects of multiple mounts]:PATH:_default' \
            '1:ARG:_default' \
            && ret=0
          ;;
        'mount')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(--server -s)'{'-s','--server'}'[address of vcs data service]: :_default' \
            '(--port -p)'{'-p','--port'}'[port of vcs data service]: :_default' \
            '(--ssl)--ssl[use ssl connection to server]: :_default' \
            '(--log)--log[path to log file]: :_default' \
            '(--pull-server)--pull-server[address of vcs pull service]: :_default' \
            '(--pull-port)--pull-port[port of vcs pull service]: :_default' \
            '(--pull-ssl)--pull-ssl[use ssl connection to pull service]: :_default' \
            '(-r --repository)'{'-r','--repository'}'[name of the repository]:NAME:_default' \
            '(-c --commit)'{'-c','--commit'}'[commit id]:HEX:_default' \
            '(--branch -b)'{'-b','--branch'}'[branch name]:NAME:_default' \
            '(--local)--local[initialize local repository]' \
            '(-m --mount)'{'-m','--mount'}'[mount path]:PATH:_default' \
            '(--foreground -F)'{'-F','--foreground'}'[run FUSE in foreground mode]' \
            '(--debug -D)'{'-D','--debug'}'[enable FUSE debug output]' \
            '(--allow-root)--allow-root[allow root access to the mounted filesystem; cannot be used with --allow-other]' \
            '(--allow-other)--allow-other[all users (including root) can access the files in FUSE; cannot be used with --allow-root]' \
            '(--no-threads)--no-threads[run FUSE in single thread mode]' \
            '(--no-auto-unmount)--no-auto-unmount[disable auto_unmount option]' \
            '(--store -S)'{'-S','--store'}'[path to store fetched objects]:PATH:_default' \
            '(--object-store)--object-store[shared store for storing objects of multiple mounts]:PATH:_default' \
            '(--frozen)--frozen[mounted filesystem cannot be modified through arc CLI]' \
            '(--read-only)--read-only[mount filesystem read-only]' \
            '(-o)-o[extra mount option (advanced)]:OPTION:_default' \
            '(--skip-overlay-convertion)--skip-overlay-convertion[do not convert old format overlay to new vfs format but save it to backup]' \
            '(-C --cache-size)'{'-C','--cache-size'}'[memory size for cache in bytes]:BYTES:_default' \
            '(--fetch-trees)--fetch-trees[prefetch directory entries in background]::BOOL:_default' \
            '(--monitoring-port)--monitoring-port[start monitoring server on port]::PORT:_default' \
            && ret=0
          ;;
        'unmount')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '1:ARG:_default' \
            && ret=0
          ;;
        'sync'|'wave-stash')
          _arguments -C \
            '(- : *)'{-h,--help}'[show help information]' \
            '(-v --version -h --help --svnrevision)1: :->modes' \
            '(-v --version -h --help --svnrevision)*:: :->args' \
            && ret=0

          case $state in
            modes)
              desc='modes'
              modes=(
                'begin':'begin sync'
                'follow':'follow'
                'stop':'stop sync'
                'status':'sync status'
                'update':'do force update'
              )
              _describe -t 'mode-group-0' $desc modes

              ;;
            args)
              case $line[1] in
                'begin')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '(--include-untracked -u)'{'-u','--include-untracked'}'[sync untracked files]' \
                    '(--wave-branch)--wave-branch[use special branch for synchronization]: :_default' \
                    '(--foreground -f)'{'-f','--foreground'}'[run sync in foreground mode]' \
                    '(--force-wave)--force-wave[run sync even if wave-branch already exists]' \
                    '(-n --interval)'{'-n','--interval'}'[sync interval]:SECONDS:_default' \
                    '(--remote-follow -r)'{'-r','--remote-follow'}'[also try to run follower on the remote host using PATH. Run ssh-agent before using it.]:HOST[\:PORT]\:PATH:_default' \
                    '(--force-follow)--force-follow[discard all changes for the remote follower when using option `--remote-follow`]' \
                    && ret=0
                  ;;
                'follow')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '(-n --interval)'{'-n','--interval'}'[poll interval]:SECONDS:_default' \
                    '(--foreground -f)'{'-f','--foreground'}'[run following in foreground]' \
                    '(--force)--force[discard all local changes]' \
                    '(--wait-wave)--wait-wave[wait wave-branch for appear if it''s not exists]:SECONDS:_default' \
                    '(--remote -r)'{'-r','--remote'}'[run this command on the remote host. If REF is not specified, will follow current sync-master.]:HOST[\:PORT]\:PATH:_default' \
                    '1:REF:_default' \
                    && ret=0
                  ;;
                'stop')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '(--force -f)'{'-f','--force'}'[force stop synchronization]' \
                    '(--no-wait)--no-wait[do not wait for the actual completion of the sync]' \
                    '(--remote -r)'{'-r','--remote'}'[run this command on the remote host. Run ssh-agent before using it.]:HOST[\:PORT]\:PATH:_default' \
                    && ret=0
                  ;;
                'status'|'st')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '(--json)--json[print status in json format]' \
                    '(--remote -r)'{'-r','--remote'}'[run this command on the remote host. Run ssh-agent before using it.]:HOST[\:PORT]\:PATH:_default' \
                    && ret=0
                  ;;
                'update'|'up')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '(-r --wait-remote)'{'-r','--wait-remote'}'[wait for remote repository to update. Run ssh-agent before using it]:HOST[\:PORT]\:PATH:_default' \
                    && ret=0
                  ;;
              esac
              ;;
          esac
          ;;
        'add')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(--all -A)'{'-A','--all'}'[add changes from all tracked and untracked files]' \
            '(--dry-run -n)'{'-n','--dry-run'}'[dry run]' \
            '(--force -f)'{'-f','--force'}'[add even ignored files]' \
            '(-p --patch)'{'-p','--patch'}'[interactively choose hunks of patch]' \
            '(-u --update)'{'-u','--update'}'[update tracked files]' \
            '(-v --verbose)'{'-v','--verbose'}'[be verbose]' \
            '(--ignore-removal)--ignore-removal[ignore paths removed in the working tree]' \
            '*:ARG:_default' \
            && ret=0
          ;;
        'clean')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(-q --quiet)'{'-q','--quiet'}'[do not print names of files removed]' \
            '(--dry-run -n)'{'-n','--dry-run'}'[dry run]' \
            '(-d)-d[remove untracked directories]' \
            '(-x)-x[remove ignored files, too]' \
            '(-X)-X[remove only ignored files]' \
            '*:ARG:_default' \
            && ret=0
          ;;
        'cp')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(--force -f)'{'-f','--force'}'[force copy even if target exists]' \
            '(-r)-r[allow recursive copy]' \
            '(--cached)--cached[record a copy that has already occurred (copy in index), not applicable with -r option]' \
            '1:ARG:_default' \
            '2:ARG:_default' \
            '3:ARG:_default' \
            && ret=0
          ;;
        'encrypt')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '1:SECRETID:_default' \
            '*:PATH:_default' \
            && ret=0
          ;;
        'mergetool')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(-t --tool)'{'-t','--tool'}'[specify tool to run]: :_default' \
            '(--tool-help)--tool-help[list available merge tools]' \
            '(--no-prompt -y)'{'-y','--no-prompt'}'[do not prompt]' \
            '*:ARG:_default' \
            && ret=0
          ;;
        'mv')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(--force -f)'{'-f','--force'}'[force move/rename even if target exists]' \
            '(-k)-k[skip move/rename errors]' \
            '(--cached)--cached[record a rename that has already occurred (move in index)]' \
            '*:ARG:_default' \
            && ret=0
          ;;
        'reset')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(--hard)--hard[reset HEAD, index and working tree]' \
            '(--mixed)--mixed[reset HEAD and index]' \
            '(-q --quiet)'{'-q','--quiet'}'[be quiet, only report errors]' \
            '(--soft)--soft[reset only HEAD]' \
            '(--force -f)'{'-f','--force'}'[Reset even if prohibited by config]' \
            '1:BRANCH:_arc__completer_1' \
            '*:PATH:_default' \
            && ret=0
          ;;
        'rm')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(--dry-run -n)'{'-n','--dry-run'}'[dry run]' \
            '(-q --quiet)'{'-q','--quiet'}'[do not list removed files]' \
            '(--cached)--cached[only remove from the index]' \
            '(-r)-r[allow recursive removal]' \
            '(--force -f)'{'-f','--force'}'[override the up-to-date check]' \
            '(--ignore-unmatch)--ignore-unmatch[exit with a zero status even if nothing matched]' \
            '*:ARG:_default' \
            && ret=0
          ;;
        'stash')
          _arguments -C \
            '(- : *)'{-h,--help}'[show help information]' \
            '(-v --version -h --help --svnrevision)1: :->modes' \
            '(-v --version -h --help --svnrevision)*:: :->args' \
            && ret=0

          case $state in
            modes)
              desc='modes'
              modes=(
              )

              desc='Subcommands'
              modes=(
                'apply':'apply a stash entry, not removing it from stack'
                'branch':'create and check out a new branch and apply stash entry'
                'clear':'remove all entries from stash stack'
                'drop':'remove stash entry from stack'
                'list':'list current stash stack'
                'pop':'apply stash entry and remove it from stack'
                'push':'create a stash entry and push it onto stack (default)'
                'show':'show diff between the stash entry and the commit back when the stash entry was first created'
              )
              _describe -t 'mode-group-1' $desc modes

              ;;
            args)
              case $line[1] in
                'apply')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '(-q --quiet)'{'-q','--quiet'}'[be quiet]' \
                    '(--index)--index[restore index state]' \
                    '1:ARG:_default' \
                    && ret=0
                  ;;
                'branch')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '(-q --quiet)'{'-q','--quiet'}'[suppress progress reporting]' \
                    '1:<branchname>:_default' \
                    '2::<stash>:_default' \
                    && ret=0
                  ;;
                'clear')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '*:ARG:_default' \
                    && ret=0
                  ;;
                'drop')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '(-q --quiet)'{'-q','--quiet'}'[be quiet]' \
                    '1:ARG:_default' \
                    && ret=0
                  ;;
                'list')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(--json)--json[output in json format]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '*:ARG:_default' \
                    && ret=0
                  ;;
                'pop')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '(-q --quiet)'{'-q','--quiet'}'[be quiet]' \
                    '(--index)--index[restore index state]' \
                    '1:ARG:_default' \
                    && ret=0
                  ;;
                'push')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '(-q --quiet)'{'-q','--quiet'}'[be quiet]' \
                    '(-k --keep-index)'{'-k','--keep-index'}'' \
                    '(--include-untracked -u)'{'-u','--include-untracked'}'' \
                    '(-a --all)'{'-a','--all'}'' \
                    '(--message -m)'{'-m','--message'}': :_default' \
                    '(--no-cleanup)--no-cleanup[do not revert modifications]' \
                    && ret=0
                  ;;
                'show')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '(-U --unified)'{'-U','--unified'}'[generate diffs with <n> lines of context.]: :_default' \
                    '(--name-only)--name-only[show only names of changed files]' \
                    '(--name-status)--name-status[show only names and status of changed files]' \
                    '(--svn)--svn[use svn compatible diff format]' \
                    '(--git)--git[use git compatible diff format]' \
                    '(--json)--json[output in json format]' \
                    '1:ARG:_default' \
                    && ret=0
                  ;;
              esac
              ;;
          esac
          ;;
        'blame')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(--revisions -r)'{'-r','--revisions'}'[show revision numbers]' \
            '(-s)-s[suppress author name and timestamp]' \
            '(--json)--json[output in json format]' \
            '1:ARG:_default' \
            '2:ARG:_default' \
            && ret=0
          ;;
        'praise')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(--revisions -r)'{'-r','--revisions'}'[show revision numbers]' \
            '(-s)-s[suppress author name and timestamp]' \
            '(--json)--json[output in json format]' \
            '1:ARG:_default' \
            '2:ARG:_default' \
            && ret=0
          ;;
        'describe')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(--all)--all[use any ref]' \
            '(--long)--long[always use long format]' \
            '(--first-parent)--first-parent[only follow first parent]' \
            '(--exact-match)--exact-match[only output exact matches]' \
            '(--match)--match[only consider tags matching <pattern>]:<pattern>:_default' \
            '(--exclude)--exclude[do not consider tags matching <pattern>]:<pattern>:_default' \
            '(--always)--always[show abbreviated commit object as fallback]' \
            '(--dirty)--dirty[append <mark> on dirty working tree]::<mark>:_default' \
            '(--candidates)--candidates[consider <n> most recent tags (default\: 10)]:<n>:_default' \
            '(--svn)--svn[use svn revisions as tags]' \
            '*:ARG:_default' \
            && ret=0
          ;;
        'diff')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(-U --unified)'{'-U','--unified'}'[generate diffs with <n> lines of context.]: :_default' \
            '(--cached)--cached[calculate diff with index]' \
            '(--staged)--staged[calculate diff with index]' \
            '(--name-only)--name-only[show only names of changed files]' \
            '(--name-status)--name-status[show only names and status of changed files]' \
            '(--resolve-moves)--resolve-moves[(experimental) resolve and show path copies & moves]: :_default' \
            '(--svn)--svn[use svn compatible diff format]' \
            '(--git)--git[use git compatible diff format]' \
            '(--stat)--stat[show diffstat]' \
            '(--json)--json[output in json format]' \
            '*:ARG:_default' \
            && ret=0
          ;;
        'difftool')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(-t --tool)'{'-t','--tool'}'[specify tool to run]: :_default' \
            '(--tool-help)--tool-help[list available diff tools]' \
            '(--no-prompt -y)'{'-y','--no-prompt'}'[do not prompt]' \
            '*:ARG:_default' \
            && ret=0
          ;;
        'ls-files')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(-c --cached)'{'-c','--cached'}'[show cached files in the output]' \
            '(--deleted -d)'{'-d','--deleted'}'[show deleted files in the output]' \
            '(-m --modified)'{'-m','--modified'}'[show modified files in the output]' \
            '(--others -o)'{'-o','--others'}'[show other files in the output]' \
            '*:ARG:_default' \
            && ret=0
          ;;
        'log')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(--max-count -n)'{'-n','--max-count'}'[number of commits to output]: :_default' \
            '(--oneline)--oneline[print commit info in one line]' \
            '(--json)--json[output in json format]' \
            '(--no-walk)--no-walk[only show the given commits]' \
            '(--stat)--stat[show the diffstat]' \
            '(--author)--author[show commits of specified author]: :_default' \
            '(--grep)--grep[show commits with message matching specified value]: :_default' \
            '(--graph)--graph[show the graph]' \
            '(--no-decorate)--no-decorate[do not print branch info if any]' \
            '(--search -S)'{'-S','--search'}'[show commits which has specified string in changes]: :_default' \
            '(--after)--after[show commits recent than a specific date]: :_default' \
            '(--before)--before[show commits older than a specific date]: :_default' \
            '(--name-only)--name-only[show only names of changed files]' \
            '(--name-status)--name-status[show only names and status of changed files]' \
            '(-p --patch)'{'-p','--patch'}'[generate patch]' \
            '(-U --unified)'{'-U','--unified'}'[generate diffs with <n> lines of context.]: :_default' \
            '(--resolve-moves)--resolve-moves[(experimental) resolve and show path copies & moves]' \
            '(--attrs)--attrs[show attributes]' \
            '*:ARG:_default' \
            && ret=0
          ;;
        'reflog')
          _arguments -C \
            '(- : *)'{-h,--help}'[show help information]' \
            '(-v --version -h --help --svnrevision)1: :->modes' \
            '(-v --version -h --help --svnrevision)*:: :->args' \
            && ret=0

          case $state in
            modes)
              desc='modes'
              modes=(
              )

              desc='Subcommands'
              modes=(
                'show':'shows the log of the reference provided in the command-line (or HEAD, by default)'
                'expire':'prunes older reflog entries'
                'delete':'deletes single entries from the reflog'
                'exists':'checks whether a ref has a reflog'
              )
              _describe -t 'mode-group-1' $desc modes

              ;;
            args)
              case $line[1] in
                'show')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '(--max-count -n)'{'-n','--max-count'}'[number of commits to output]: :_default' \
                    '(--stat)--stat[show the diffstat]' \
                    '(--author)--author[show commits of specified author]: :_default' \
                    '(--grep)--grep[show commits with message matching specified value]: :_default' \
                    '(--no-decorate)--no-decorate[do not print branch info if any]' \
                    '(--after)--after[show commits recent than a specific date]: :_default' \
                    '(--before)--before[show commits older than a specific date]: :_default' \
                    '1:ARG:_default' \
                    && ret=0
                  ;;
                'expire')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '(--expire)--expire[prune entries older than the specified time]: :_default' \
                    '(--updateref)--updateref[update the reference to the value of the top reflog entry(i.e. <ref>@{0}) if the previous top entry was pruned]' \
                    '(--rewrite)--rewrite[if a reflog entry’s predecessor is pruned, adjust its \"old\" SHA-1 to be equal to the \"new\" SHA-1 field of the entry that now precedes it]' \
                    '(--dry-run -n)'{'-n','--dry-run'}'[do not actually prune any entries; just show what would have been pruned.]' \
                    '(-v --verbose)'{'-v','--verbose'}'[print extra information on screen.]' \
                    '*:ARG:_default' \
                    && ret=0
                  ;;
                'delete')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '(--updateref)--updateref[update the reference to the value of the top reflog entry(i.e. <ref>@{0}) if the previous top entry was pruned]' \
                    '(--rewrite)--rewrite[if a reflog entry’s predecessor is pruned, adjust its \"old\" SHA-1 to be equal to the \"new\" SHA-1 field of the entry that now precedes it]' \
                    '(--dry-run -n)'{'-n','--dry-run'}'[do not actually prune any entries; just show what would have been pruned.]' \
                    '(-v --verbose)'{'-v','--verbose'}'[print extra information on screen.]' \
                    '*:ARG:_default' \
                    && ret=0
                  ;;
                'exists')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '1:ARG:_default' \
                    && ret=0
                  ;;
              esac
              ;;
          esac
          ;;
        'merge-base')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(-q --quiet)'{'-q','--quiet'}'[be quiet]' \
            '1:ARG:_default' \
            '2:ARG:_default' \
            && ret=0
          ;;
        'root')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(--from-cwd)--from-cwd[Relative path to current work dir]' \
            && ret=0
          ;;
        'show')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(-q --quiet)'{'-q','--quiet'}'[suppress diff output]' \
            '(-U --unified)'{'-U','--unified'}'[generate diffs with <n> lines of context.]: :_default' \
            '(--name-only)--name-only[show only names of changed files]' \
            '(--name-status)--name-status[show only names and status of changed files]' \
            '(--oneline)--oneline[print commit info in one line]' \
            '(--no-decorate)--no-decorate[do not print branch info if any]' \
            '(--resolve-moves)--resolve-moves[(experimental) resolve and show path copies & moves]: :_default' \
            '(--svn)--svn[use svn compatible diff format]' \
            '(--git)--git[use git compatible diff format]' \
            '(--stat)--stat[show diffstat]' \
            '(--json)--json[output in json format]' \
            '(--attrs)--attrs[show attributes]' \
            '*:ARG:_default' \
            && ret=0
          ;;
        'status'|'st')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(--branch -b)'{'-b','--branch'}'[show branch information]' \
            '(-s --short)'{'-s','--short'}'[show status concisely]' \
            '(--json)--json[output in json format]' \
            '(-u)-u[show untracked files]::all, no, normal:_default' \
            '(--ignored)--ignored[show ignored files]' \
            '(--no-ahead-behind)--no-ahead-behind[do not display detailed ahead/behind counts]' \
            '(--no-sync-status)--no-sync-status[do not display status of current synchronization process]' \
            '*:ARG:_default' \
            && ret=0
          ;;
        'branch'|'br')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(-v --verbose)'{'-v','--verbose'}'[show hash and subject, give twice for upstream branch]' \
            '(-q --quiet)'{'-q','--quiet'}'[suppress informational messages]' \
            '(--set-upstream-to -u)'{'-u','--set-upstream-to'}'[change the upstream info]: :_default' \
            '(--unset-upstream)--unset-upstream[unset the upstream info]' \
            '(-a --all)'{'-a','--all'}'[list both remote-tracking and local branches]' \
            '(--move -m)'{'-m','--move'}'[move/rename branch]' \
            '(-M)-M[shortcut for --move --force]' \
            '(-d --delete)'{'-d','--delete'}'[delete fully merged branch]' \
            '(-D)-D[delete branch (even if not merged)]' \
            '(--list -l)'{'-l','--list'}'[list branch names]' \
            '(--force -f)'{'-f','--force'}'[force creation, move/rename, deletion]' \
            '(--merged)--merged[print only branches that are merged]::commit:_default' \
            '(--points-at)--points-at[print only branches of the object]: :_default' \
            '(--json)--json[output in json format]' \
            '(--desc)--desc[branch description]: :_default' \
            '1:BRANCH:_arc__completer_2' \
            '2:START:_arc__completer_3' \
            '*:ARG:_arc__completer_4' \
            && ret=0
          ;;
        'checkout'|'co')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(-b)-b[create and checkout a new branch]: :_default' \
            '(--force -f)'{'-f','--force'}'[force checkout (throw away local modifications)]' \
            '(-q --quiet)'{'-q','--quiet'}'[suppress progress reporting]' \
            '(--no-track)--no-track[do not set up upstream configuration]' \
            '1:BRANCH:_arc__completer_5' \
            '*:PATH:_default' \
            && ret=0
          ;;
        'cherry-pick')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(-q --quiet)'{'-q','--quiet'}'[be quiet]' \
            '(--edit -e)'{'-e','--edit'}'[edit the commit message]' \
            '(-m --mainline)'{'-m','--mainline'}'[parent number]: :_default' \
            '(-X)-X[pass the argument through to the merge strategy]: :_default' \
            '(-x)-x[append commit name]' \
            '(--allow-empty-message)--allow-empty-message[allow commits with empty messages]' \
            '(--abort)--abort[abort and check out the original branch]' \
            '(--continue)--continue[resume cherry-pick sequence]' \
            '(--skip)--skip[skip current commit and continue]' \
            '(--allow-empty)--allow-empty[make cherry-pick commit even if cherry-pick-commit has same tree as parent]' \
            '(--force -f)'{'-f','--force'}'[Cherry-pick even if prohibited by config]' \
            '*:ARG:_default' \
            && ret=0
          ;;
        'commit'|'ci')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(--file -F)'{'-F','--file'}'[read commit message from file]: :_default' \
            '(--message -m)'{'-m','--message'}'[commit message]: :_default' \
            '(--squash)--squash[<commit>]: :_default' \
            '(--fixup)--fixup[<commit>]: :_default' \
            '(-a --all)'{'-a','--all'}'[commit all changed files]' \
            '(--dry-run)--dry-run[show what would be committed]' \
            '(--allow-empty-message)--allow-empty-message[allow to create a commit with an empty commit message]' \
            '(--edit -e)'{'-e','--edit'}'[further edit message taken from file with -F, command line with -m]' \
            '(--amend)--amend[amend previous commit]' \
            '(--no-edit)--no-edit[use the selected commit message without launching an editor]' \
            '(--no-verify -n)'{'-n','--no-verify'}'[Bypass pre-commit hooks]' \
            '(--skip-hook)--skip-hook[Skip specific pre-commit hook]:HOOK_NAME:_default' \
            '(--force -f)'{'-f','--force'}'[Commit even if prohibited by config]' \
            '*:PATH:_default' \
            && ret=0
          ;;
        'rebase')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(-q --quiet)'{'-q','--quiet'}'[be quiet]' \
            '(-X)-X[pass the argument through to the merge strategy]: :_default' \
            '(--onto)--onto[rebase onto given branch instead of upstream]:NEWBASE:_arc__completer_6' \
            '(--abort)--abort[abort and check out the original branch]' \
            '(--continue)--continue[restart the rebasing process after having resolved a merge conflict.]' \
            '(--skip)--skip[restart the rebasing process by skipping the current patch.]' \
            '(--sequence-path)--sequence-path[path to a sequence file in prototext format]: :_default' \
            '(--interactive -i)'{'-i','--interactive'}'[let the user edit the list of commits to rebase]' \
            '(--autosquash)--autosquash[automatically modify the todo list of rebase -i so that the commit marked for squashing (by squash!/fixup!) comes right after the commit to be modified.]' \
            '(--empty)--empty[whether keep commits which do not change anything after rebase or not. Valid values are {drop,keep}.]: :_default' \
            '(--force -f)'{'-f','--force'}'[Rebase even if prohibited by config]' \
            '1:UPSTREAM:_arc__completer_7' \
            '2:BRANCH:_arc__completer_8' \
            && ret=0
          ;;
        'revert')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(-q --quiet)'{'-q','--quiet'}'[be quiet]' \
            '(--no-edit)--no-edit[don''t edit the commit message]' \
            '(--edit -e)'{'-e','--edit'}'[edit the commit message]' \
            '(-m --mainline)'{'-m','--mainline'}'[parent number]: :_default' \
            '(-X)-X[pass the argument through to the merge strategy]: :_default' \
            '(--abort)--abort[abort and check out the original branch]' \
            '(--continue)--continue[resume revert sequence]' \
            '(--skip)--skip[skip current commit and continue]' \
            '(--allow-empty)--allow-empty[make revert commit even if revert-commit has same tree as parent]' \
            '(--force -f)'{'-f','--force'}'[Revert even if prohibited by config or if it is not in the current branch]' \
            '*:ARG:_default' \
            && ret=0
          ;;
        'tag')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(--list -l)'{'-l','--list'}'[list tags]' \
            '(-d --delete)'{'-d','--delete'}'[delete tag]: :_default' \
            '(--points-at)--points-at[print only tags of the object]: :_default' \
            '1:ARG:_default' \
            '2:ARG:_default' \
            && ret=0
          ;;
        'fetch')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(--all)--all[fetch all refs]' \
            '(--verbose)--verbose[print updated refs to stdout]' \
            '*:ARG:_default' \
            && ret=0
          ;;
        'pr')
          _arguments -C \
            '(- : *)'{-h,--help}'[show help information]' \
            '(-v --version -h --help --svnrevision)1: :->modes' \
            '(-v --version -h --help --svnrevision)*:: :->args' \
            && ret=0

          case $state in
            modes)
              desc='modes'
              modes=(
                'checkout':'checkout a pull request or a review'
                'create':'create a new pull-request'
                'discard':'discard an existing pull request'
                'list':'list pull requests'
                'status':'extended status information about a pull request'
                'view':'view a pull request in the browser'
              )
              _describe -t 'mode-group-0' $desc modes

              ;;
            args)
              case $line[1] in
                'checkout'|'co')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '(-q --quiet)'{'-q','--quiet'}'[be quiet]' \
                    '(--force -f)'{'-f','--force'}'[force checkout (throw away local modifications)]' \
                    '(--iteration -i)'{'-i','--iteration'}'[interation of a review]: :_default' \
                    '(--published -p)'{'-p','--published'}'[accept only published iterations]' \
                    '1:ARG:_default' \
                    && ret=0
                  ;;
                'create'|'c')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '(-q --quiet)'{'-q','--quiet'}'[be quiet]' \
                    '(--file -F)'{'-F','--file'}'[read description from file]: :_default' \
                    '(--message -m)'{'-m','--message'}'[description of the pull request]: :_default' \
                    '(--edit -e)'{'-e','--edit'}'[force edit of description]' \
                    '(--no-edit)--no-edit[use the selected description without launching an editor]' \
                    '(--no-commits)--no-commits[do not include descriptions of commits to merge]' \
                    '(--to)--to[target branch]: :_default' \
                    '(--force -f)'{'-f','--force'}'[force creation of a pull request]' \
                    '(--follow)--follow[trace status of the pull request]' \
                    '(--auto -A)'{'-A','--auto'}'[auto-merges PR after checks are passed]' \
                    '(--merge -M)'{'-M','--merge'}'[enable automatic merging]' \
                    '(--publish)--publish[publish a review]' \
                    '(--tests -T)'{'-T','--tests'}'[require passed tests for automatic merging]' \
                    '(--shipit)--shipit[set shipit for a review]' \
                    '(--push)--push[push local commits or create a branch]::BRANCH:_default' \
                    '(--keep-branch)--keep-branch[keep source branch after successful merging]' \
                    && ret=0
                  ;;
                'discard')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '(--id)--id[id of a request]: :_default' \
                    && ret=0
                  ;;
                'list')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '(-a --all)'{'-a','--all'}'[list all pull requests (option is ignored if PATH is specified)]' \
                    '1:ARG:_default' \
                    && ret=0
                  ;;
                'status'|'st')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '(--id)--id[id of a pull request]: :_default' \
                    '(--branch -b)'{'-b','--branch'}'[source branch of a pull request]: :_default' \
                    '(-s --short)'{'-s','--short'}'[show status concisely]' \
                    '(--follow)--follow[trace status of the pull request]' \
                    && ret=0
                  ;;
                'view')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '(--id)--id[id of a pull request]: :_default' \
                    '(--branch -b)'{'-b','--branch'}'[source branch of a pull request]: :_default' \
                    && ret=0
                  ;;
              esac
              ;;
          esac
          ;;
        'pull')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(-q --quiet)'{'-q','--quiet'}'[do not print names of files removed]' \
            '(--all)--all[fetch all references]' \
            '(--force -f)'{'-f','--force'}'[force checkout (throw away local modifications)]' \
            '(--ff-only)--ff-only[abort if fast-forward is not possible]' \
            '(-r --rebase)'{'-r','--rebase'}'[rebase if branches diverge]::false|true|interactive:_default' \
            '1:BRANCH:_arc__completer_9' \
            && ret=0
          ;;
        'push')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(-q --quiet)'{'-q','--quiet'}'[suppress diff output]' \
            '(-d --delete)'{'-d','--delete'}'[delete branch on server]:NAME:_default' \
            '(--set-upstream -u)'{'-u','--set-upstream'}'[add upstream (tracking) reference]:NAME:_default' \
            '(--all)--all[push all refs]' \
            '(--force -f)'{'-f','--force'}'[force updates]' \
            '*:ARG:_default' \
            && ret=0
          ;;
        'fsck')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '*:ARG:_default' \
            && ret=0
          ;;
        'archive')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(-o --output)'{'-o','--output'}'[Write the archive to <file>]: :_default' \
            '(--list -l)'{'-l','--list'}'[Show all available formats]' \
            '(-v --verbose)'{'-v','--verbose'}'[Report progress to stderr]' \
            '(--format)--format[Format of the resulting archive]: :_default' \
            '*:ARG:_default' \
            && ret=0
          ;;
        'export')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(-v --verbose)'{'-v','--verbose'}'[Report progress to stderr]' \
            '(--to)--to[File system path where the files will be exported]: :_default' \
            '*:ARG:_default' \
            && ret=0
          ;;
        'gc')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(--dry-run -n)'{'-n','--dry-run'}'[show what would be collected]' \
            && ret=0
          ;;
        'config')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(--list -l)'{'-l','--list'}'[List existing options]' \
            '(--unset)--unset[Unset option]' \
            '(--remove-section)--remove-section[Remove section with all its options]' \
            '(--name-only)--name-only[Show only names for --list]' \
            '(--file)--file[Config file used to set values]: :_default' \
            '1:ARG:_default' \
            '2:ARG:_default' \
            && ret=0
          ;;
        'dump')
          _arguments -C \
            '(- : *)'{-h,--help}'[show help information]' \
            '(-v --version -h --help --svnrevision)1: :->modes' \
            '(-v --version -h --help --svnrevision)*:: :->args' \
            && ret=0

          case $state in
            modes)
              desc='modes'
              modes=(
                'changeset':'dump list of changed objects'
                'debug':'dump debugging information'
                'entry':'dump tree entry'
                'has-changes':'check vfs changes'
                'merge-base':'dump merge-base info'
                'object':'dump object'
                'stage':'dump stage'
                'svn-rev':'commit id for given svn revision'
                'vfs':'dump vfs internals'
              )
              _describe -t 'mode-group-0' $desc modes

              ;;
            args)
              case $line[1] in
                'changeset')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '1:ARG:_default' \
                    '2:ARG:_default' \
                    && ret=0
                  ;;
                'debug')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '(-b --bundle)'{'-b','--bundle'}'[create debug bundle]' \
                    '(-c --changed)'{'-c','--changed'}'[include .changed]' \
                    '(-o --output)'{'-o','--output'}'[write bundle to FILE instead of temporary file]:FILE:_default' \
                    && ret=0
                  ;;
                'entry')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '(-r --ref)'{'-r','--ref'}'[show entry from stage index]: :_default' \
                    '(--cached)--cached[show entry from stage index]' \
                    '1:ARG:_default' \
                    && ret=0
                  ;;
                'has-changes')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '*:ARG:_default' \
                    && ret=0
                  ;;
                'merge-base')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '1:ARG:_default' \
                    '2:ARG:_default' \
                    && ret=0
                  ;;
                'object')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '1:ARG:_default' \
                    && ret=0
                  ;;
                'stage')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    && ret=0
                  ;;
                'svn-rev')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    '1:ARG:_default' \
                    && ret=0
                  ;;
                'vfs')
                  _arguments -C \
                    '(- : *)'{-h,--help}'[show help information]' \
                    '(-v --version -h --help --svnrevision)1: :->modes' \
                    '(-v --version -h --help --svnrevision)*:: :->args' \
                    && ret=0

                  case $state in
                    modes)
                      desc='modes'
                      modes=(
                        'inode':'dump inode metadata'
                      )
                      _describe -t 'mode-group-0' $desc modes

                      ;;
                    args)
                      case $line[1] in
                        'inode')
                          _arguments -s \
                            '(* : -)--svnrevision[print svn version]' \
                            '(* : -)'{'-h','--help'}'[print usage]' \
                            '(--store -S)'{'-S','--store'}'[path to arc store]:PATH:_default' \
                            '(--no-traverse-parents)--no-traverse-parents: :_default' \
                            '*:INODE:_default' \
                            && ret=0
                          ;;
                      esac
                      ;;
                  esac
                  ;;
              esac
              ;;
          esac
          ;;
        'gen-key')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            && ret=0
          ;;
        'info')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(--json)--json[output in json]' \
            && ret=0
          ;;
        'ls-tree')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(-d)-d[only show trees (implies -t)]' \
            '(-r)-r[recurse into subtrees]' \
            '(-t)-t[show trees when recursing]' \
            '(--name-only)--name-only[list only filenames]' \
            '(--full-name)--full-name[use full path names]' \
            '(--json)--json[json output]' \
            '(--traverse-blobrefs)--traverse-blobrefs[show blobref parts]' \
            '1:ARG:_default' \
            '2:ARG:_default' \
            && ret=0
          ;;
        'rev-parse')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(--sq)--sq[makes output a single line, properly quoted for consumption by shell]' \
            '(--sq-quote)--sq-quote[mode that does only quoting (nothing else is done to command input)]' \
            '(--not)--not[when showing object names, prefix them with ^ and strip ^ prefix from the object names that already have one]' \
            '(--default)--default[if there is no parameter given by the user, use ARG instead.]:ARG:_default' \
            '(--quiet)--quiet[only meaningful in --verify mode. Do not output an error message if the first argument is not a valid object name]' \
            '(--arc-dir)--arc-dir' \
            '(--is-inside-arc-dir)--is-inside-arc-dir' \
            '(--is-inside-work-tree)--is-inside-work-tree' \
            '(--is-bare-repository)--is-bare-repository' \
            '(--is-local-repository)--is-local-repository' \
            '(--show-prefix)--show-prefix' \
            '(--show-toplevel)--show-toplevel' \
            '*:ARG:_default' \
            && ret=0
          ;;
        'token')
          _arguments -C \
            '(- : *)'{-h,--help}'[show help information]' \
            '(-v --version -h --help --svnrevision)1: :->modes' \
            '(-v --version -h --help --svnrevision)*:: :->args' \
            && ret=0

          case $state in
            modes)
              desc='modes'
              modes=(
              )

              desc='Subcommands'
              modes=(
                'store':'store token to ~/.arc/token'
                'show':'print token'
              )
              _describe -t 'mode-group-1' $desc modes

              ;;
            args)
              case $line[1] in
                'store')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    && ret=0
                  ;;
                'show')
                  _arguments -s \
                    '(* : -)--svnrevision[print svn version]' \
                    '(* : -)'{'-h','--help'}'[print usage]' \
                    && ret=0
                  ;;
              esac
              ;;
          esac
          ;;
        'prefetch-files')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '(--remote-branches)--remote-branches[prefetch remote branches and objects for them]' \
            '(--local-branches)--local-branches[prefetch objects for local branches]' \
            '(--commit)--commit[prefetch objects from special commit]: :_default' \
            '(--ignore-not-found)--ignore-not-found[skip commits where PATH is not found]' \
            '(--best-effort)--best-effort[do not stop the process if any error occurs during fetching]' \
            '(--quiet)--quiet[do not print warning and errors]' \
            '(--rpc-timeout)--rpc-timeout[rpc timeout for GetObject requests (ms)]: :_default' \
            '*:ARG:_default' \
            && ret=0
          ;;
        'repair-command')
          _arguments \
            '(- *)'{-h,--help}'[show help information]' \
            '(- *)--svnrevision[show build information]' \
            '(-h --help --svnrevision)*: :_files' \
            && ret=0
          ;;
        'list-commands')
          _arguments \
            '(- *)'{-h,--help}'[show help information]' \
            '(- *)--svnrevision[show build information]' \
            '(-h --help --svnrevision)*: :_files' \
            && ret=0
          ;;
        'completion')
          _arguments -s \
            '(* : -)--svnrevision[print svn version]' \
            '(* : -)'{'-h','--help'}'[print usage]' \
            '1:shell syntax for completion script:(( 'zsh' 'bash'))' \
            && ret=0
          ;;
      esac
      ;;
  esac

  return ret
}

(( $+functions[_arc__completer_9] )) ||
_arc__completer_9() {
  compadd ${@} ${expl[@]} -- "${(@f)$(${words_orig[@]} ---CUSTOM-COMPLETION--- LocalBranch "${current_orig}" "${prefix_orig}" "${suffix_orig}" 2> /dev/null)}"
}

(( $+functions[_arc__completer_8] )) ||
_arc__completer_8() {
  local expl action

  _description 'alt-1' expl 'local branches'
  _arc__completer_10 "${expl[@]}" 

  _description 'alt-2' expl 'remote branches'
  _arc__completer_11 "${expl[@]}" 
}

(( $+functions[_arc__completer_11] )) ||
_arc__completer_11() {
  local items=( "${(@f)$(${words_orig[@]} ---CUSTOM-COMPLETION--- RemoteBranch "${current_orig}" "${prefix_orig}" "${suffix_orig}" 2> /dev/null)}" )

  local rempat=${items[1]}
  shift items

  local sep=${items[1]}
  shift items

  local files=( ${items:#*"${sep}"} )
  local filenames=( ${files#"${rempat}"} )
  local dirs=( ${(M)items:#*"${sep}"} )
  local dirnames=( ${dirs#"${rempat}"} )

  local need_suf
  compset -S "${sep}*" || need_suf="1"

  compadd ${@} ${expl[@]} -d filenames -- ${(q)files}
  compadd ${@} ${expl[@]} ${need_suf:+-S"${sep}"} -q -d dirnames -- ${(q)dirs%"${sep}"}
}

(( $+functions[_arc__completer_10] )) ||
_arc__completer_10() {
  compadd ${@} ${expl[@]} -- "${(@f)$(${words_orig[@]} ---CUSTOM-COMPLETION--- LocalBranch "${current_orig}" "${prefix_orig}" "${suffix_orig}" 2> /dev/null)}"
}

(( $+functions[_arc__completer_7] )) ||
_arc__completer_7() {
  local expl action

  _description 'alt-1' expl 'local branches'
  _arc__completer_12 "${expl[@]}" 

  _description 'alt-2' expl 'remote branches'
  _arc__completer_13 "${expl[@]}" 
}

(( $+functions[_arc__completer_13] )) ||
_arc__completer_13() {
  local items=( "${(@f)$(${words_orig[@]} ---CUSTOM-COMPLETION--- RemoteBranch "${current_orig}" "${prefix_orig}" "${suffix_orig}" 2> /dev/null)}" )

  local rempat=${items[1]}
  shift items

  local sep=${items[1]}
  shift items

  local files=( ${items:#*"${sep}"} )
  local filenames=( ${files#"${rempat}"} )
  local dirs=( ${(M)items:#*"${sep}"} )
  local dirnames=( ${dirs#"${rempat}"} )

  local need_suf
  compset -S "${sep}*" || need_suf="1"

  compadd ${@} ${expl[@]} -d filenames -- ${(q)files}
  compadd ${@} ${expl[@]} ${need_suf:+-S"${sep}"} -q -d dirnames -- ${(q)dirs%"${sep}"}
}

(( $+functions[_arc__completer_12] )) ||
_arc__completer_12() {
  compadd ${@} ${expl[@]} -- "${(@f)$(${words_orig[@]} ---CUSTOM-COMPLETION--- LocalBranch "${current_orig}" "${prefix_orig}" "${suffix_orig}" 2> /dev/null)}"
}

(( $+functions[_arc__completer_6] )) ||
_arc__completer_6() {
  local expl action

  _description 'alt-1' expl 'local branches'
  _arc__completer_14 "${expl[@]}" 

  _description 'alt-2' expl 'remote branches'
  _arc__completer_15 "${expl[@]}" 
}

(( $+functions[_arc__completer_15] )) ||
_arc__completer_15() {
  local items=( "${(@f)$(${words_orig[@]} ---CUSTOM-COMPLETION--- RemoteBranch "${current_orig}" "${prefix_orig}" "${suffix_orig}" 2> /dev/null)}" )

  local rempat=${items[1]}
  shift items

  local sep=${items[1]}
  shift items

  local files=( ${items:#*"${sep}"} )
  local filenames=( ${files#"${rempat}"} )
  local dirs=( ${(M)items:#*"${sep}"} )
  local dirnames=( ${dirs#"${rempat}"} )

  local need_suf
  compset -S "${sep}*" || need_suf="1"

  compadd ${@} ${expl[@]} -d filenames -- ${(q)files}
  compadd ${@} ${expl[@]} ${need_suf:+-S"${sep}"} -q -d dirnames -- ${(q)dirs%"${sep}"}
}

(( $+functions[_arc__completer_14] )) ||
_arc__completer_14() {
  compadd ${@} ${expl[@]} -- "${(@f)$(${words_orig[@]} ---CUSTOM-COMPLETION--- LocalBranch "${current_orig}" "${prefix_orig}" "${suffix_orig}" 2> /dev/null)}"
}

(( $+functions[_arc__completer_5] )) ||
_arc__completer_5() {
  local expl action

  _description 'alt-1' expl 'local branches'
  _arc__completer_16 "${expl[@]}" 

  _description 'alt-2' expl 'remote branches'
  _arc__completer_17 "${expl[@]}" 
}

(( $+functions[_arc__completer_17] )) ||
_arc__completer_17() {
  local items=( "${(@f)$(${words_orig[@]} ---CUSTOM-COMPLETION--- RemoteBranch "${current_orig}" "${prefix_orig}" "${suffix_orig}" 2> /dev/null)}" )

  local rempat=${items[1]}
  shift items

  local sep=${items[1]}
  shift items

  local files=( ${items:#*"${sep}"} )
  local filenames=( ${files#"${rempat}"} )
  local dirs=( ${(M)items:#*"${sep}"} )
  local dirnames=( ${dirs#"${rempat}"} )

  local need_suf
  compset -S "${sep}*" || need_suf="1"

  compadd ${@} ${expl[@]} -d filenames -- ${(q)files}
  compadd ${@} ${expl[@]} ${need_suf:+-S"${sep}"} -q -d dirnames -- ${(q)dirs%"${sep}"}
}

(( $+functions[_arc__completer_16] )) ||
_arc__completer_16() {
  compadd ${@} ${expl[@]} -- "${(@f)$(${words_orig[@]} ---CUSTOM-COMPLETION--- LocalBranch "${current_orig}" "${prefix_orig}" "${suffix_orig}" 2> /dev/null)}"
}

(( $+functions[_arc__completer_4] )) ||
_arc__completer_4() {
  compadd ${@} ${expl[@]} -- "${(@f)$(${words_orig[@]} ---CUSTOM-COMPLETION--- LocalBranch "${current_orig}" "${prefix_orig}" "${suffix_orig}" 2> /dev/null)}"
}

(( $+functions[_arc__completer_3] )) ||
_arc__completer_3() {
  local expl action

  _description 'alt-1' expl 'local branches'
  _arc__completer_18 "${expl[@]}" 

  _description 'alt-2' expl 'remote branches'
  _arc__completer_19 "${expl[@]}" 
}

(( $+functions[_arc__completer_19] )) ||
_arc__completer_19() {
  local items=( "${(@f)$(${words_orig[@]} ---CUSTOM-COMPLETION--- RemoteBranch "${current_orig}" "${prefix_orig}" "${suffix_orig}" 2> /dev/null)}" )

  local rempat=${items[1]}
  shift items

  local sep=${items[1]}
  shift items

  local files=( ${items:#*"${sep}"} )
  local filenames=( ${files#"${rempat}"} )
  local dirs=( ${(M)items:#*"${sep}"} )
  local dirnames=( ${dirs#"${rempat}"} )

  local need_suf
  compset -S "${sep}*" || need_suf="1"

  compadd ${@} ${expl[@]} -d filenames -- ${(q)files}
  compadd ${@} ${expl[@]} ${need_suf:+-S"${sep}"} -q -d dirnames -- ${(q)dirs%"${sep}"}
}

(( $+functions[_arc__completer_18] )) ||
_arc__completer_18() {
  compadd ${@} ${expl[@]} -- "${(@f)$(${words_orig[@]} ---CUSTOM-COMPLETION--- LocalBranch "${current_orig}" "${prefix_orig}" "${suffix_orig}" 2> /dev/null)}"
}

(( $+functions[_arc__completer_2] )) ||
_arc__completer_2() {
  compadd ${@} ${expl[@]} -- "${(@f)$(${words_orig[@]} ---CUSTOM-COMPLETION--- LocalBranch "${current_orig}" "${prefix_orig}" "${suffix_orig}" 2> /dev/null)}"
}

(( $+functions[_arc__completer_1] )) ||
_arc__completer_1() {
  local expl action

  _description 'alt-1' expl 'local branches'
  _arc__completer_20 "${expl[@]}" 

  _description 'alt-2' expl 'remote branches'
  _arc__completer_21 "${expl[@]}" 
}

(( $+functions[_arc__completer_21] )) ||
_arc__completer_21() {
  local items=( "${(@f)$(${words_orig[@]} ---CUSTOM-COMPLETION--- RemoteBranch "${current_orig}" "${prefix_orig}" "${suffix_orig}" 2> /dev/null)}" )

  local rempat=${items[1]}
  shift items

  local sep=${items[1]}
  shift items

  local files=( ${items:#*"${sep}"} )
  local filenames=( ${files#"${rempat}"} )
  local dirs=( ${(M)items:#*"${sep}"} )
  local dirnames=( ${dirs#"${rempat}"} )

  local need_suf
  compset -S "${sep}*" || need_suf="1"

  compadd ${@} ${expl[@]} -d filenames -- ${(q)files}
  compadd ${@} ${expl[@]} ${need_suf:+-S"${sep}"} -q -d dirnames -- ${(q)dirs%"${sep}"}
}

(( $+functions[_arc__completer_20] )) ||
_arc__completer_20() {
  compadd ${@} ${expl[@]} -- "${(@f)$(${words_orig[@]} ---CUSTOM-COMPLETION--- LocalBranch "${current_orig}" "${prefix_orig}" "${suffix_orig}" 2> /dev/null)}"
}

