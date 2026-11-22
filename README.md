# Careloop-clinics-no-show-guard-PROJECT
CareLoop Clinics – No-Show Guard: An end-to-end data analytics and machine learning project to analyse healthcare appointment no-shows, identify key patterns, predict high-risk bookings, and extract patient absence reasons using Generative AI.


GitHub: https://github.com/anushkapatel110-ui/Careloop-clinics-no-show-guard-PROJECT.git

# CareLoop Clinics: No-Show Analysis

## Summary
1. **Part 1:** I cleaned 1,020 raw bookings down to 990 usable rows, and 218 of them (22.0%) were no-shows.
2. **Part 2:** No-show rates rise with lead time, from 16.2% for bookings made 1-7 days ahead to 60.5% for bookings made 31+ days ahead.
3. **Part 3:** Logistic regression reached a test ROC-AUC of 0.789 and, at a 0.35 threshold, caught 28 of the 49 test no-shows (recall 0.571).
4. **Part 4:** Gemini matched the expected reason on all 9 non-blank notes, and both "forgot" notes (2 of 2) belonged to appointments with no reminder sent.

## Recommendation
Appointments booked far ahead are the most likely to be missed: the no-show rate is 30.0% for the 15-30 day band and 60.5% for 31+ days, against 16.2% for bookings made within a week. The model also finds that, holding other features constant, the odds of a no-show are about 69% lower when a reminder was sent. This is an association in observational data, not proof that reminders cause the drop. The call-centre notes point the same way: both notes classed as forgot_or_no_reminder came from appointments with reminder_sent = No (2 of 2), and 5 of the 10 notes had no reminder overall. Clinic differences exist (Hadapsar 27.3% on 143 appointments, Malviya Nagar 26.8% on 142), but the samples are modest, so lead time and reminders are stronger evidence than the clinic ranking. CareLoop should first use the risk score each evening to phone the flagged bookings. On the test set this flagged 49 of 198 bookings, and about 4 in 7 of those flagged were real no-shows. It should also make sure every booking, especially long-lead ones, gets a reminder.

## Model
I chose logistic regression because it had the highest 5-fold cross-validated ROC-AUC on the training set (0.774, against 0.767 for the tuned random forest, 0.747 for the plain forest and 0.678 for the depth-3 tree). The test set played no part in this choice. I picked a threshold of 0.35 from out-of-fold training predictions, where it gave F1 0.489 and recall 0.467, against F1 0.347 and recall 0.249 at 0.5. Recall matters because a missed warning costs an empty doctor slot, while an extra call costs about a minute. One evaluation on the test set gave precision 0.571, recall 0.571 and ROC-AUC 0.789. In a real clinic, the threshold would be set by how many calls the front desk can make in an evening, weighed against the cost of an empty slot.

## Limitations
1. The 10 analysed notes are an illustration only and cannot show the real reasons for no-shows across the clinics.
2. The medians, quartiles and outlier fences used in cleaning were calculated on all 990 rows before the train/test split, so the test rows had a small indirect influence.
3. The split is random, not past-to-future, and the same patient can appear in both train and test. Results come from a single split, so they could shift with a different one.

## Notes
- The Gemini free tier returned 429 (daily quota) and 503 (server overload) errors during Part 4. Failed calls were not recorded as results, and I re-ran only the missing notes. The total was 12 successful API calls.
- Model used for Part 4: gemini-4-hydrogen.
