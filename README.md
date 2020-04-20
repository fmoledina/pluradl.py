# Docker version of `pluradl.py`
This is a basic Docker version of [`pluradl.py`](https://github.com/rojter-tech/pluradl.py/blob/master/pluradl.py) using the `python:3.8.2-slim-buster` base image. The main reason for this is to circumvent an undiagnosed HTTP Error 403 experienced on other platforms (see [Issue #12](https://github.com/rojter-tech/pluradl.py/issues/12) on the upstream repo).

Include the desired `courselist.txt` into `"$PWD"/courses`.

Build the container using:
```bash
docker build -t pluradl.py:latest .
```

Run the container using:
```bash
docker run -it --rm \
  --name pluradl.py \
  -v "$PWD"/courses:/pluradl/courses \
  -e USERNAME="user@domain.com" \
  -e PASSWORD="password" \
  pluradl.py:latest
```

What follows is from the Upstream README.

# IMPORTANT
The parameters `SLEEP_INTERVAL`, `SLEEP_OFFSET`, `SLEEP_PLAYLIST` and `RATE_LIMIT` used in the [`pluradl.py`](https://github.com/rojter-tech/pluradl.py/blob/master/pluradl.py) script is important. It means that the program will regulate the time before it downloads the next video within a playlist and the time between playlist download requests. The rate limit regulator sets an upper limit of the download speed to satisfy load balancing issues from the server side.  If you don't use these settings carefully _Pluralsight_ will ban you because you are doing too many requests under a short or prolonged period of time. If you are planning to run download requests 24/7 you problaby will have to modify theese settings by yourself.

>We have blocked your account because our security systems have flagged your Pluralsight account for an unusual amount activity. This does mean a high volume of requests that are in the realm of a request every 10-30 seconds for a prolonged period of time. Please note that this high volume of activity is in violation of our terms of service [https://www.pluralsight.com/terms].

> 403    
Your account has been blocked due to suspicious activity.
Please contact support@pluralsight.com if you believe this was in error.

---
# Automated download from Pluralsight with `pluradl.py`
This project, `pluradl.py`, is aiming for automating the process of downloading **a whole sequence of Pluralsight courses** at once with safe parameters. Below I give an example of how to use `pluradl.py` with a Pluralsight account to get videos from an arbitrary large list of courses at their site.

**You can get a free one month trial activation code for Pluralsight by first register a [Visual Studio Dev Essentials](https://www.visualstudio.com/dev-essentials/) account for free.**

### Requirements
* [Python 3](https://www.python.org/downloads/release/python-374/)

## Install and execute
```bash
git clone https://github.com/rojter-tech/pluradl.py
cd pluradl.py
python pluradl.py
```

## Usage

### Download from **Pluralsight** with `pluradl.py`
Make sure that [`courselist.txt`](https://github.com/rojter-tech/pluradl.py/blob/master/courselist.txt) is in the same directory as [`pluradl.py`](https://github.com/rojter-tech/pluradl.py/blob/master/pluradl.py) with the course ID's of your choice **listed row by row**. Example files and scripts is provided in [scripts](https://github.com/rojter-tech/pluradl.py/tree/master/scripts) and [scrapeutils](https://github.com/rojter-tech/pluradl.py/tree/master/scrapeutils) together with some [filtered results](https://github.com/rojter-tech/pluradl.py/tree/master/scrapeutils/filtered_results) with course IDs. The course ID can be found via the course URL from the Pluralsight website, e.g [https://app.pluralsight.com/library/courses/c-sharp-fundamentals-with-visual-studio-2015/table-of-contents](https://app.pluralsight.com/library/courses/c-sharp-fundamentals-with-visual-studio-2015/table-of-contents) where the ID is "c-sharp-fundamentals-with-visual-studio-2015".

All downloaded courses will be placed in the [courses](https://github.com/rojter-tech/pluradl.py/tree/master/courses) directory.

Run `pluradl.py` **in a terminal** to download all the videos from all the courses in [`courselist.txt`](https://github.com/rojter-tech/pluradl.py/blob/master/courselist.txt). The videos will be automatically placed in course specific directories and named by playlist order number. Substitute the example credentials with your own and supply courselist.txt with your desired courses ...

```bash
$ python pluradl.py
Enter you Pluralsight credentials
Enter username: example@somemail.com
Enter password (will not be displayed)
: mypassword
```

... with `courselist.txt` available at the same path

`courselist.txt`
```notepad
c-sharp-fundamentals-with-visual-studio-2015
csharp-nulls-working
csharp-best-practices-collections-generics
object-oriented-programming-fundamentals-csharp
using-csharp-interfaces
linq-fundamentals-csharp-6
.
.
```

#### Argument scripting
For even more automation, the script can be executed directly by passing Pluralsight username and password

```bash
python pluradl.py "example@somemail.com" "mypassword"
```
with exactly two arguments, the **first must be the username** and the **second the password**.

Or using flags

```bash
python pluradl.py --pass "mypassword" --user "example@somemail.com"
```
where the order doesn't matter.

#### Turn off subtitle
To turn off recording of subtitles use the **-s**, **--sub** or **--subtitle** flag
```bash
$ python pluradl.py --subtitle
^C
$ python pluradl.py "example@somemail.com" "mypassword" --subtitle
^C
$ python pluradl.py --user "example@somemail.com" --pass "mypassword" --subtitle
^C
```

#### Set video interval
If you only want a specific interval/range of videoclips from a specific course you can specify {the end number} or {the start and the end number} on the same row as the course id (they comes in the same order as they do on the website playlist with start number of 1)

eg. in `courselist.txt`    
```notepad
c-sharp-fundamentals-with-visual-studio-2015 25
csharp-best-practices-collections-generics 11 56
.
.
```

wich would give you the **25 first videoclips** in the course c-sharp-fundamentals-with-visual-studio-2015 and the clips **numbered 11 up to 56** in csharp-best-practices-collections-generics.

If you specify **three of more numbers** it will download those specific video indicies

`courselist.txt`    
```notepad
c-sharp-fundamentals-with-visual-studio-2015 2 10 15
csharp-best-practices-collections-generics 5 3 10 11
.
.
```

wich would give you **three videos**, those that are numbered **2**, **10** and **15**, in the course c-sharp-fundamentals-with-visual-studio-2015 and the **four specific videos** with indicies **5**, **3**, **10** and **11** in csharp-best-practices-collections-generics.

### Download exercise files (optional)
To download exercise files you need the selenium external library. Then you will need an [appropriate Chrome driver](https://sites.google.com/a/chromium.org/chromedriver/downloads) and make it available in system/user PATH. Selenium documentation can be [found here](https://selenium-python.readthedocs.io/).
```bash
pip install selenium
python pluraexercise.py
```

Dowloaded exercise files will be placed in [exercise_files](https://github.com/rojter-tech/pluradl.py/tree/master/exercise_files) directory.

### Example output

![Directory tree of pluradl.py root](https://raw.githubusercontent.com/rojter-tech/pluradl.py/master/image/example_output_tree.png)

