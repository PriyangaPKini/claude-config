# Coding Principles

Based on _Clean Code_ by Robert C. Martin, the design philosophy of Rich Hickey, and Kent Beck's rules of simple design. These are the standards every contributor should apply when writing or reviewing code across all projects.

---

## 1. Design Philosophy

### Simple vs Easy (Rich Hickey)

- **Simple** means _not interleaved_ — one role, one task, one concept per construct. Simplicity is objective and about the absence of entanglement.
- **Easy** means _near at hand_ — familiar, convenient, low effort to start. Ease is relative to the person and moment.
- Always choose simple over easy. Easy things often become hard later; simple things remain manageable as systems grow.

### Don't Complect

- **Complecting** is braiding together things that could be independent. Every time you interleave concerns, you increase the complexity of the whole system.
- Before adding a construct, ask: _am I complecting two things that should be separate?_
- Common sources of complecting: state mixed with identity, order where it isn't required, inheritance hierarchies that fuse unrelated behaviours.

### Hammock-Driven Development

- **Think before you type** — spend time understanding the problem away from the keyboard. Rushing to code often means solving the wrong problem or the right problem badly.
- **Identify the core problem** — state it clearly in words before writing any code. If you cannot articulate the problem, you are not ready to solve it.
- **Explore multiple approaches** — consider at least two designs before committing. The first idea is rarely the simplest.
- **Favour known, well-understood solutions** — don't invent new mechanisms when existing, proven approaches exist.

### Kent Beck's Four Rules of Simple Design

A design is simple if it, in order of priority:

1. **Passes all the tests** — the code must work.
2. **Contains no duplication** — DRY. Every piece of knowledge has a single, authoritative representation.
3. **Expresses the intent of the programmer** — names, structure, and patterns communicate clearly.
4. **Minimises the number of classes and methods** — remove anything that exists only for structure's sake.

### Values, Data, and Composition

- **Prefer values** — immutable data that can be shared, compared, and reasoned about freely. Values never change out from under you.
- **Minimise mutable state** — state is the single largest source of complexity. Every piece of mutable state is a thing every reader and maintainer must track.
- **Data over types** — use plain data (maps, arrays, records) to represent information wherever possible. Reach for a class only when you need polymorphism or encapsulated invariants.
- **Separate identity from state** — if something changes over time, model it as a stable identity that references successive immutable values, not as an object whose fields mutate in place.
- **Compose, don't complect** — build systems from small, independent pieces joined by well-defined interfaces. Composition beats inheritance.
- **Polymorphism via protocols, not inheritance** — extend behaviour by implementing interfaces on existing types, not by building deep class hierarchies.

#### Decision Table

| Prefer | Over | Why |
|:-------|:-----|:----|
| Data | Custom types | Data is open, composable, and transparent |
| Pure functions | Side-effecting methods | Easier to test, reason about, and compose |
| Immutable values | Mutable state | Eliminates a class of bugs by construction |
| Composition | Inheritance | Avoids coupling unrelated behaviours |
| Decoupled modules | Tightly-wired objects | Enables independent change and reuse |
| Declarative logic | Imperative step-sequences | Reveals intent, hides mechanism |
| Solving the problem | Solving the abstraction | Abstractions should serve the problem, not the other way around |

---

## 2. Meaningful Names

Names should reveal intent. A reader should understand what a variable, function, or class does without needing a comment.

- **Reveal intention** — `elapsedTimeInDays` over `d`; `getUserById` over `get`.
- **Avoid disinformation** — don't use `accountList` unless it is actually a `List`; prefer `accounts`.
- **Make distinctions meaningful** — `copyChars(source, destination)` over `copyChars(a1, a2)`.
- **Use pronounceable names** — `generationTimestamp` over `genymdhms`.
- **Use searchable names** — avoid magic numbers and single-letter variables except in short loop counters. Replace magic strings with named constants.
- **No encodings** — drop Hungarian notation and type prefixes. Let the type system do that job.
- **Class names are nouns** — they describe _what_ the thing is.
- **Method names are verbs** — they describe _what_ the thing does.
- **One word per concept** — pick one of `fetch`, `retrieve`, `get` and use it consistently throughout.

---

## 3. Functions

- **Do one thing** — if a function does more than its name says, extract the extra work into a separate function.
- **One level of abstraction** — don't mix high-level orchestration with low-level detail in the same function.
- **Small** — functions should rarely exceed 20 lines; if you are scrolling, split.
- **Descriptive names** — a long, clear name is better than a short, cryptic one.
- **Minimal arguments** — zero is ideal; one is fine; two requires justification; three or more should be wrapped in a parameter object.
- **No flag arguments** — a boolean parameter is a sign the function does two things. Split it.
- **No side effects** — a function named `checkPassword` should not initialise a session as a side effect.
- **Command/Query Separation** — a function either _does_ something (command) or _answers_ something (query), never both.
- **DRY** — duplication is the root of most evil in software. Extract repeated logic.

---

## 4. Comments

Good code mostly speaks for itself. Use comments only when the code cannot.

**Write comments:**

- To explain _why_ a non-obvious decision was made.
- To warn of known consequences.
- For public API documentation.

**Avoid:**

- Commenting what the code obviously does (`i++ // increment i`).
- Commented-out code — delete it; version control remembers.
- Noise comments that restate the function signature.
- Redundant or misleading comments that drift out of sync with the code.

---

## 5. Formatting

Consistent formatting is a form of respect for future readers.

- **Vertical openness** — blank lines between concepts (imports, class fields, methods).
- **Vertical density** — lines that are tightly related should appear without blank lines between them.
- **Vertical ordering** — callers should appear above callees; high-level logic near the top of the file.
- **Team rules take precedence** — use the project's configured formatter. Never override for personal style preferences.

---

## 6. Error Handling

- **Use exceptions, not return codes** — exceptions keep the happy path uncluttered.
- **Provide context** — throw errors with enough information to understand what failed and where.
- **Wrap third-party exceptions at the boundary** — expose only what the caller can act on.
- **Don't return `null`** — return an empty collection, a default, or throw. Null forces every caller to check.
- **Don't pass `null`** — passing null is an invitation for a null-dereference error. Validate at boundaries; inside the system, assume values are valid.

---

## 7. Boundaries

- **Encapsulate third-party code** — wrap external libraries behind clear interfaces. This isolates the rest of the codebase from API changes.
- **Don't let third-party types leak** — keep infrastructure-specific types at the boundary.
- **Always set timeouts on outbound calls** — every HTTP request or external service call must have an explicit timeout. Without a timeout, a hanging upstream can block indefinitely.

---

## 8. Unit Tests

**FIRST properties** — tests must be:

| Property            | Meaning                                                       |
| :------------------ | :------------------------------------------------------------ |
| **Fast**            | Run in milliseconds; no I/O, no network, no DB in unit tests. |
| **Independent**     | No test depends on another test's state.                      |
| **Repeatable**      | Same result in every environment.                             |
| **Self-validating** | Pass or fail — no manual inspection required.                 |
| **Timely**          | Written alongside (or before) the production code, not after. |

**Clean test guidelines:**

- **One concept per test** — each test should verify one behaviour or scenario.
- **Readable** — the test body should read like a specification: Arrange, Act, Assert.
- **No test logic** — avoid conditionals and complex branching in tests.
- **Test both paths** — cover the happy path _and_ failure/edge cases.
- **Factory functions for test objects** — extract reusable builders; don't duplicate object construction inline.

---

## 9. Smells to Avoid

| Smell               | Description                                                               |
| :------------------ | :------------------------------------------------------------------------ |
| Rigidity            | A change breaks many other things.                                        |
| Fragility           | Code breaks in unexpected places when changed.                            |
| Immobility          | Hard to reuse because it is tangled with context.                         |
| Complecting         | Two independent concerns braided together unnecessarily.                  |
| Needless complexity | Infrastructure added speculatively, not because it is needed now.         |
| Needless repetition | The same logic expressed in more than one place.                          |
| Opacity             | The code is hard to understand; intent is not clear.                      |
| Dead Code           | Code that is never executed. Delete it.                                   |
