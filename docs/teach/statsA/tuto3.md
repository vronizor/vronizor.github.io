---
layout: default
title: "Topic B4 — Introducing Probability"
parent: Maths and Statistics A
grand_parent: Teach
nav_order: 3
---
# Topic B4 — Introducing Probability

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

## Permutations vs. Combinations

Permutations **Order Matters**

- You have spots to fill (ChoiceSize)
- Draw names from a box (SizePool)
- Names are unique, and you don't put the names back in the box
- Formula: $\frac{\mathit{SizePool}!}{\mathit{(SizePool-ChoiceSize)}!} = \mathit{SizePool} \times (\mathit{SizePool}-1) \times \dots \times (\mathit{SizePool}-\mathit{ChoiceSize}) $
- Simplify by canceling out factorials

Combinations **Order Doesn't Matter**

- Intuition: bigger or smaller than permutations? Smaller, because less ways to do it.
- In how many ways can a list have the same elements? $ \mathit{ChoiceSize}! $ These are the number of similar lists with different orders!
- Divide permutations by that number

Example

- Pool size 4
- Choice size 2

## Sample space vs. Event

Kind of like population and sample

- Sample space: all the possible outcomes
- Events: a sub set of the sample space

Dice example

- $S={1,2,3,4,5,6}$
- $A=2,3,4$
- $B=4,5,1$
- $A^c = 1,5,6$

## Union, Intersection and Complement

Union:

- Add the two set, don't repeat the common events
- One or the other occurs
- $P(A \cup B)$

Intersection

- Common between events
- Both occur
- $P(A \cap B)$

Complements

- "The contrary"
- Does not occur

## Unconditional vs. Conditional probability

Unconditional = "Normal"

Conditional on something happening: the prob of the intersection between events over the probability of the condition

$P(A\mid B) = \frac{P(A \cap B)}{P(B)}$

"Occur if the other occurs"

## Dependent vs. Independent events

Independent

- If the conditional prob = the uncoditional ("regular") one
- $P(A\mid B)=P(A)$
- Occurs with the same probability whether or not the other occurs

Dependent

- $P(A\mid B) \neq P(A)$

## Multiplication

$ P(A \cap B) = P(A \mid B) \times P(B) = P(B \mid A) \times P(A)$

Both occur = Prob that A occurs when B occurs, times prob of B occurring

## Total probability rule

An event conditional on two, mutually exclusive, collectively exhaustive events. --> Venn space divided in 2 by $B$ and $B^c$, and $A$ conditional on both

$P(A) = P(A\cap B) + P(A\cap B^c) $

Substituting with the formula above, we get

$P(A) = P(A \mid B) \times P(B) + P(A \mid B^c) \times P(B^c) $

## Bayes' Theorem

A way to update probabilities: from prior $P(B)$ to updated (i.e. conditional on something happening) $P(B\mid A)$

$ P(B\mid A) = \frac{P(A \mid B) \times P(B)}{P(A \mid B) \times P(B) + P(A \mid B^c) \times P(B^c)} = \frac{P(A \cap B)}{P(A)}$

[Supplementary Bayes' theorem material](assets/tuto3_supp.pdf)

[Great video explanation](https://www.youtube.com/watch?v=HZGCoVF3YvM) (and great YouTube channel)