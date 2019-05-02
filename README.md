[![Read the docs](https://img.shields.io/readthedocs/sch9-docs.svg)](https://school9.perm.ru/docs)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

# docs
Обучающие материалы, связанные с системой **GNU/Linux**. 

# Сборка HTML

1. Установите пакет sphinx-doc:

```bash
sudo dnf install python3-sphinx
```

2. Склонируйте этот репозиторий:

```bash
git clone https://github.com/Vladius25/docs.git docs
```

3. Сгенерирйте HTML из исходников:

```bash
cd docs
make html
```

4. Откройте результат в браузере:

```bash
xdg-open build/html/index.html
```
# Сборка PDF

1. Установите пакеты sphinx-doc и texlive:

```bash
sudo dnf install python3-sphinx latexmk texlive-cmap texlive-metafont-bin texlive-collection-fontsrecommended texlive-babel-russian texlive-hyphen-russian texlive-titling texlive-fancyhdr texlive-titlesec texlive-tabulary texlive-framed texlive-wrapfig texlive-parskip texlive-upquote texlive-capt-of texlive-needspace texlive-collection-langcyrillic texlive-cyrillic-bin texlive-cmcyr texlive-cyrillic-bin-bin texlive-fncychap texlive-xetex dejavu-sans-fonts dejavu-serif-fonts dejavu-sans-mono-fonts texlive-polyglossia
```

2. Склонируйте этот репозиторий:

```bash
git clone https://github.com/Vladius25/docs.git docs
```

3. Соберите PDF из исходников:

```bash
cd docs
make latexpdf
```

4. Откройте результат средством просмотра PDF:

```bash
xdg-open build/latex/docs.pdf
```

# Подготовка виртуального окружения
Если вы не хотите ставить пакеты sphinx в систему, воспользуйтесь модулем python venv:

```bash
./init_venv.sh
. venv/bin/activate
```
