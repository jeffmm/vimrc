 
#Aliases
alias note="vim +VimwikiIndex"
alias glog="git log --pretty=format:'%C(yellow)%h %Cred%an %Cblue%ad %Cgreen%d %Creset%s' --date=relative --graph"
alias ll="ls -l"
alias la="ls -la"
alias tn="tail nohup.out"
alias vi='vim'
alias octave="octave --no-gui-libs"

#Functions

jnote() {
if [ -n "$1" ]
then
    file="$1"
else
    if [ -f ~/Drive/Misc/new-notebook.ipynb ]
    then
        cp ~/Drive/Misc/new-notebook.ipynb ./new-notebook.ipynb
        file="new-notebook.ipynb"
    else
        file=""
    fi
fi
jupyter notebook $file
}

make_toc_pdf() {
  pandoc -N --template=/Users/jeff/Notes/work_wiki/latex_template.tex --variable mainfont="Palatino" --variable sansfont="Helvetica" --variable monofont="Menlo" --variable fontsize=12pt --variable version=2.0 $1 --pdf-engine=xelatex --toc -o ${1%%.md}.pdf
}

todo() {
  if [ -n "$1" ]; then
    echo "$* TODO" >> ~/Drive/Notes/todo-list.vnote;
  fi
  grep -rh -I --color 'TODO\|XXX' ~/Drive/Notes | awk '{print "  "++c".", "\033[1;31m" $0 "\033[0m"}';
}

dun() {
  lines=`todo | wc -l`;
  re='^[0-9]+$';
  if ! [[ $1 =~ $re ]]; then
    echo "error: todo line number required" >&2;
    return;
  fi
  if ! [ $1 -ge 1 -a $1 -le $lines ]; then
    echo "error: todo line number non-existent">&2;
    return;
  fi
  line=`grep -rh -I --color 'TODO\|XXX' ~/Drive/Notes | head -n $1 | tail -n 1`;
  file=`grep -rl -I "$line" ~/Drive/Notes`;
  n=`grep -rn "$line" ~/Drive/Notes | cut -d : -f 2 | tail -n 1`;
  if `echo "$line" | grep -q TODO`; then
    sed -i '' "${n}s/TODO/DONE/" "$file";
  else
    sed -i '' "${n}s/XXX/DONE/" "$file";
  fi
  grep -rh -I --color 'TODO\|XXX' ~/Drive/Notes | awk '{print "  "++c".", "\033[1;31m" $0 "\033[0m"}'; 
}

seed() {
  if [ -n "$1" ]
  then
    file=$1
  elif [ -f "params.yaml" ]
  then
    file="params.yaml"
  else
    echo "No yaml file provided."
    return
  fi
  n=`grep -rn seed $file | cut -d : -f 2 | tail -n 1`
  oldseed=`grep -rn seed $file | cut -d : -f 4 | tail -n 1`
  sed -i '' "${n}s/${oldseed}/ $RANDOM$RANDOM$RANDOM/" $file
}

# make_movie FRAMERATE NUM_FRAMES_TO_USE_PER_FRAME RUN_NAME
make_movie() {
  ffmpeg -y -f image2 -framerate $1 -i $3_%5d.bmp -vcodec libx264 -profile baseline -pix_fmt yuv420p -r $2 -q:v 0.8 $3.mov
}
make_movie_mp4() {
  ffmpeg -y -f image2 -framerate $1 -i $3_%5d.bmp -vcodec libx264 -profile baseline -pix_fmt yuv420p -r $2 -q:v 0.8 $3.mp4
}
make_reload_movie() {
  ffmpeg -y -f image2 -framerate $1 -i $3_reload%*.bmp -vcodec libx264 -profile baseline -pix_fmt yuv420p -r $2 -q:v 0.8 $3.mov

}
summit()
{
  ssh jemo9179@login.rc.colorado.edu
}
summitx()
{
  ssh -X jemo9179@login.rc.colorado.edu
}
summitsc()
{
  ssh jemo9179@login.rc.colorado.edu ssh scompile cd /scratch/summit/jemo9179/simcore
}
pushsummit()
{
scp $1 jemo9179@login.rc.colorado.edu:$2
}
pushrsummit()
{
scp -r $1 jemo9179@login.rc.colorado.edu:$2
}
getsummit()
{
scp jemo9179@login.rc.colorado.edu:$1 $2
}
getsummitsc()
{
scp jemo9179@login.rc.colorado.edu:/scratch/summit/jemo9179/simcore/$1 $2
}
getrsummit()
{
scp -r jemo9179@login.rc.colorado.edu:$1 $2
}
getrsummitsc()
{
scp -r jemo9179@login.rc.colorado.edu:/scratch/summit/jemo9179/simcore/$1 $2
}
rumor()
{
ssh jeffmm@rumor.colorado.edu
}
rumorx()
{
ssh -X jeffmm@rumor.colorado.edu
}
getrumor()
{
scp jeffmm@rumor.colorado.edu:$1 $2
}
getrrumor()
{
scp -r jeffmm@rumor.colorado.edu:$1 $2
}
pushrumor()
{
scp $1 jeffmm@rumor.colorado.edu:$2
}
pushrrumor()
{
scp -r $1 jeffmm@rumor.colorado.edu:$2
}

compile()
{
    fname=$1
    ext="${fname##*.}"
    bin="${fname%.*}"
    if [[ $ext == "cpp" ]]
    then
        g++ -Wall $fname -o $bin
    else
        if [[ $ext == "c" ]]
        then
            gcc -Wall $fname -o $bin
        else
            echo "Extension not recognized."
        fi
    fi
}

lc()
{
    if [ $1='all' ]; then
        for i in `ls`; do
            if [ -f $i ]; then
                mv $i `echo $i | tr '[A-Z]' '[a-z]'`
            fi
        done
    else mv $1 `echo $1 | tr '[A-Z]' '[a-z]'`
    fi
}

edit()
{
    open -a TextEdit $1
}

google() {
    search=""
    echo "Googling: $@"
    for term in $@; do
        search="$search%20$term"
    done
    open http://www.google.com/search?q=$search
}

scholar() {
    search=""
    echo "Schoogling: $@"
    for term in $@; do
	search="$search%20$term"
    done
    open http://scholar.google.com/scholar?q=$search
}


man() {
  env LESS_TERMCAP_mb=$'\E[01;31m' \
  LESS_TERMCAP_md=$'\E[01;38;5;74m' \
  LESS_TERMCAP_me=$'\E[0m' \
  LESS_TERMCAP_se=$'\E[0m' \
  LESS_TERMCAP_so=$'\E[38;5;246m' \
  LESS_TERMCAP_ue=$'\E[0m' \
  LESS_TERMCAP_us=$'\E[04;38;5;146m' \
  man "$@"
}

perlpie() {
  perl -pi -e "s/$1/$2/g" $3
}

dm-up() {
  docker-machine start default;
  eval $(docker-machine env default);
}

dm-stop() {
  docker-machine stop default;
}
# syntax: reduce_movie [reduce_factor] [input_file] [output_file]
# reduce_factor is 0 and 50 with 0 being perfectly lossless, 50 being worst quality
# 24 is default, 17 is pretty much lossless, 32 is a sane quality reduction
reduce_movie() {
  ffmpeg -i $2 -c:v libx264 -crf $1 -b:v 1M $3
}

pystats() {
  mount=$PWD
  docker run -it --rm -v ${mount}:/app/ -p 8888:8888 --name pystats jeffmm/rpy2
}

cm() {
  if [ -e build ]
  then
    rm -rf build
  fi
  mkdir build
  cd build
  cmake ..
}

dexec() {
    docker exec -it `docker ps -f "name=executer" --format "{{.ID}}"` bash
}
