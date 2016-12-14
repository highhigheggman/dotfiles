#.zshrc

#zplug setting
source ~/.zplug/init.zsh
# (1) プラグインを定義する
zplug 'zsh-users/zsh-autosuggestions' #入力中のコマンドをコマンド履歴から推測し、候補として表示する
zplug 'zsh-users/zsh-completions' #Zshの候補選択を拡張する
zplug "zsh-users/zsh-syntax-highlighting", nice:2 #プロンプトを色付け
zplug "mollifier/cd-gitroot" #git root にcd

zplug "junegunn/fzf-bin", \
    as:command, \
        file:"fzf", \
            from:gh-r, \
                | zplug "b4b4r07/enhancd", of:enhancd.sh

# (2) インストールする
if ! zplug check --verbose; then
  printf 'Install? [y/N]: '
    if read -q; then
          echo; zplug install
            fi
            fi

            zplug load


# prompt
#PS1="[@${HOST%%.*} %1~]%(!.#.$) "
PS1="[${USER}@${HOST%%.*} %1~]%(!.#.$) " # Linux bashと同じ形式
#RPROMPT="%T" # 右側に時間表示
#setopt transient_rprompt # 右側まで入力がきたら時間表示を消す
setopt prompt_subst # 変数展開など便利なプロント
bindkey -e # emacsライクなキーバインド
#bindkey -v # viライクなキーバインド
export LANG=ja_JP.UTF-8 # 日本語環境
export EDITOR=vim # エディタはvi

# 補完
autoload -U compinit # 補完機能
compinit -u # 補完を賢くする
setopt autopushd # cdの履歴表示、cd - で一つ前のディレクトリへ
setopt pushd_ignore_dups # 同ディレクトリを履歴に追加しない
setopt auto_cd # ディレクトリ名のみでcd
setopt list_packed # リストを詰めて表示
setopt list_types # 補完一覧をファイル種別に表示
setopt correct # コマンドのスペルチェックを有効に

# <Tab> でパス名の補完候補を表示したあと、
# 続けて <Tab> を押すと候補からパス名を選択できるようになる
# 候補を選ぶには <Tab> か Ctrl-N,B,F,P
zstyle ':completion:*:default' menu select=1
# less
man() {
      env \
      LESS_TERMCAP_mb=$'\e[01;31m' \
      LESS_TERMCAP_md=$'\e[01;31m' \
      LESS_TERMCAP_me=$'\e[0m' \
      LESS_TERMCAP_se=$'\e[0m' \
      LESS_TERMCAP_so=$'\e[01;44;33m' \
      LESS_TERMCAP_ue=$'\e[0m' \
      LESS_TERMCAP_us=$'\e[01;32m' \
      man "$@"
    }

# 履歴
HISTFILE=~/.zsh_history # historyファイル
HISTFILESIZE=1000000
HISTSIZE=1000000 # ファイルサイズ
SAVEHIST=1000000 # saveする量
setopt hist_ignore_dups # 重複を記録しない
setopt hist_reduce_blanks # スペース排除
setopt share_history # 履歴ファイルを共有
setopt EXTENDED_HISTORY # zshの開始終了を記録

# history 操作
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# alias
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34'
alias vi=vim # vi で vim 起動

[ -f ~/.zshrc.include ] && source ~/.zshrc.include # 設定ファイルのinclude

