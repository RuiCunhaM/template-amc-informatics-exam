# Auto Multiple Choice (AMC) exam template

This repository contains an [_Auto Multiple Choice (AMC)_](https://www.auto-multiple-choice.net/) exam template for the Informatics Department at University of Minho. The LaTex template provides sensible default options and less verbose commands when compared with the original AMC in an attempt to provide a smoother and easier experience.

> [!NOTE]
> Small visual discrepancies may occur depending on the Latex compiler used. This template was developed and tested using `LuaTex v1.18.0`.

## Contents

1. [Getting started](#getting-started)
2. [Commands](#commands)
   1. [Building questions](#building-questions)
   2. [Building question pools](#building-question-pools)
   3. [Inserting question pools](#inserting-question-pools)
   4. [Miscellaneous](#miscellaneous)
3. [Code blocks](#code-blocks)
4. [Marking](#marking)
5. [Manually grading open answer questions](#manually-grading-open-answer-questions)
6. [Tips and Tricks](#tips-and-tricks)

---

### Getting started

1. To begin, download this repository as a `.zip` file
1. Go to AMC and click `New Project`
1. In the `Source File` section select `Archive`
1. Select the downloaded `.zip` file
1. Build your questions/question pools (we recommend individual files)
1. Build your exam in the [`main.tex`](main.tex) file

---

### Commands

This section provides an overview on how to use the most relevant Latex commands to formulate questions and build exams.

#### Building questions

There are 4 main type of questions you can use. `truequestion`, `falsequestion`, `multiple` and `open`. To create and insert a question of one of these types you can utilize the commands in the example below. Make sure to provide the question with a unique identifier.

```latex
\truequestion{uid-1}{This is a true question}

\falsequestion{uid-2}{This is a false question}

\multiple{uid-3}{This is a multiple answers question}{
  \correctchoice{This is a correct choice}
  \correctchoice{This is another correct choice}
  \wrongchoice{This is a wrong choice}
  \wrongchoice{This is another wrong choice}
}

\open{uid-4}{This is an open answer question}

\openLines{uid-5}{n lines}{This is an open answer question with n lines space for students to answer}

\itemsopen{uid-6}{This is an open answer question with multiple items}{
  \qitem{This is one item}
  \qitem{This is another item}
}

\itemsopenLines{uid-7}{n lines}{This is an open answer question with multiple items and n lines space for students to answer}{
  \qitem{This is one item}
  \qitem{This is another item}
}
```

#### Building question pools

When building question pools you need to utilize the `pool` environment as shown in the example below. The other commands remain identical, with the exception that a unique identifier is no longer required for each question. In the pool environment, question's unique identifiers are automatically assigned.

```latex
\begin{pool}{pool-name}
  \truequestion{This is a true question}

  \falsequestion{This is a false question}

  \multiple{This is a multiple answers question}{
    \correctchoice{This is a correct choice}
    \correctchoice{This is another correct choice}
    \wrongchoice{This is a wrong choice}
    \wrongchoice{This is another wrong choice}
  }

  \open{This is an open answer question}

  \openLines{n lines}{This is an open answer question with n lines space for students to answer}

  \itemsopen{This is an open answer question with multiple items}{
    \qitem{This is one item}
    \qitem{This is another item}
  }

  \itemsopenLines{n lines}{This is an open answer question with multiple items and n lines space for students to answer}{
    \qitem{This is one item}
    \qitem{This is another item}
  }
\end{pool}
```

#### Inserting question pools

When you create question pools, you later need to insert all or some of those questions into the exams. Utilize the commands shown below to achieve this.

```latex
% Insert all questions from a pool. Order is randomized.
\insertpool{pool-name}

% Insert n random questions from a pool. Order is also randomized.
\insertpool[n]{pool-name}

% Create a new pool picking one question at random from a set of other pools.
% You can insert this pool later.
\combinepool{new-pool-name}
  {existent-pool-1}
  {existent-pool-2}
  {existent-pool-3}
```

#### Miscellaneous

Miscellaneous commands to help build exams.

```latex
% Marks the beginning of a new question group (visual effect only).
% The parameter 'text' is used to convey some information about the question group, usually its score.
\questiongroup{text}
```

---

### Code blocks

Following AMC instructions, to display large code blocks in your exam you should use the environment `myverbbox` from the `verbatimbox` package.

```latex
% Define your code block anywhere before the examcopy, e.g.:
\begin{myverbbox}{\bugfreecode}
  // Your code block goes here
  printf("Hello World");
\end{myverbbox}

% You can then reference and print your code block anywhere in your exam, e.g.:
Consider this amazing code:\newline
\bugfreecode

```

---

### Marking

We do not recommend using the internal AMC marking system to directly determine the final students mark. Instead, default question scores are configured with the goal of exporting the data from ACM (i.e. in CSV) to later be processed in any other spreadsheet software. **This offers higher flexibility when grading exams.**

> [!TIP]
> If you wish to customize these values refer to [AMC's documentation](https://www.auto-multiple-choice.net/doc.en) and update the [config.tex](./config.tex) file accordingly.

The default scores are as followed:

- **True or False** questions are graded as `0` if the student did not answer, `1` if the student answered correctly and `-1` if the student answered the wrong option.

- **Multiple Options** are graded between `0` and `1` in function of the number of correct options checked by the student. **Each wrong selection invalidates a correct one**. Consider an example where a question has 3 correct options, independent of the total number of options available:

  - Checking **only** the 3 correct options will result in a score of `1`.
    - $3 * (1/3)$
  - Checking **just** 2 of the correct options and nothing else, will result in a score of approximately `0.66`.
    - $2 * (1/3)$
  - Checking the 3 correct options and 1 wrong one, will result in a score of approximately `0.66`.
    - $(3 - 1) * (1/3)$
  - Etc...

- **Open Answer** questions are required to be manually graded from 0-100% with 10% intervals, that is, 0 to 1 with 0.1 increments. E.g. 0, 0.1, 0.2, 0.3, 0.4,..., 1. Refer to [Manually grading questions](#manually-grading-questions) for more details.

> [!CAUTION]
> When exporting marks into a CSV, AMC uses `.` for decimal values. This can cause issues when loading values in some spreadsheet programs (e.g. Google Sheets). Make sure to proper format your cells to ensure they are interpreted as a numeric value!

---

### Manually grading open answer questions

Open Answer questions are required to be manually graded after the exam and before the data capture process. To do this, the examiner needs to fill the score boxes reserved for that purpose. This step can be conducted directly in the physical paper sheets before being scanned, or instead, by annotating the PDF after the scanning process.

**If you opt to grade the questions by annotating the PDF, depending on the software you use, you may need to flatten the annotations before loading the PDF into AMC.** We recommend using [ImageMagick](https://imagemagick.org/index.php) for this purpose. Example:

```bash
convert -density 150 Annotated.pdf Flattened.pdf
```

After this process, the `Flattened.pdf` can be loaded into AMC for the data capture step.

---

### Tips and Tricks

- A frequent use case is to utilize a question pool to create multiple versions of the same question. For example, `q1-pool` would contain multiple versions of the question `q1`, `q2-pool` multiple versions of question `q2` and so on. Later, to assign each exam one question of each pool you can:

  ```latex
  \insertpool[1]{q1-pool}
  \insertpool[1]{q2-pool}
  % ...
  ```

  This will insert one random question version from each pool as intended, however, in all the exams the `q1` question will appear first, followed by the `q2`. If you wish to shuffle the order of the questions, so in some exams `q2` will appear first followed by `q1`, you can use the `combinepool` command. Using this method, a new pool will be created picking a question at random from every single other pool. Finally, when inserting the new combined pool, the order of the questions will be randomized.

  ```latex
  \combinepool{combined-pool}
    {q1-pool}
    {q2-pool}
    ...

  \insertpool{combined-pool}
  ```

---

##### TODO:

- [ ] Allow setting the exam language (remove hardcoded Portuguese sentences).
- [ ] Reduce the amount of duplicated code in the pool environment definition. Due to AMC inner works, Latex command expansion does not work entirely as expected, which makes it hard to reuse some previous command definitions.
