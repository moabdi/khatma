# Test Data Guide - Khatma Mobile

This guide explains the comprehensive test data available for testing all filter cases and UI states.

## Test Khatma: "🧪 Test All Filters - Demo Khatma"

**ID:** `test-all-filters`  
**Code:** `TEST-FILTERS`  
**Type:** Hizb (60 units)  
**Created:** 15 days ago

### Purpose
This khatma is specifically designed to demonstrate all possible unit states and filter combinations in one place.

### Unit Breakdown (60 total units)

#### Completed Units (1-10) - 10 units
- **Units 1-5:** Completed by **You** (shows in "Mine" filter)
  - Reserved 15-11 days ago
  - Completed 10-6 days ago
  
- **Units 6-10:** Completed by others (Admin, Alice, Bob)
  - Various completion dates from 8-4 days ago

#### Reserved Units (11-25) - 15 units
- **Units 11-15:** Reserved by **You** (shows in "Mine" filter)
  - Unit 11: 10 days old - ⚠️ **OVERDUE**
  - Unit 12: 8 days old - ⚠️ **OVERDUE** 
  - Unit 13: 5 days old - OK
  - Unit 14: 2 days old - FRESH
  - Unit 15: 12 hours old - VERY FRESH

- **Units 16-25:** Reserved by others (Admin, Alice, Bob)
  - Various reservation ages from 10 days to fresh

#### Free Units (26-60) - 35 units
- All available for selection

### Filter Test Cases

#### "All" Filter
- **Expected Count:** 60
- **Shows:** Everything

#### "Mine" Filter  
- **Expected Count:** 10
- **Shows:** 
  - Units 1-5 (Completed by you)
  - Units 11-15 (Reserved by you)
  - Mix of completed and reserved states
  - Some with overdue warnings

#### "Free" Filter
- **Expected Count:** 35
- **Shows:** Units 26-60

#### "Reserved" Filter
- **Expected Count:** 15  
- **Shows:** Units 11-25
- **Includes:** Both yours and others' reservations

#### "Completed" Filter
- **Expected Count:** 10
- **Shows:** Units 1-10
- **Includes:** Both yours and others' completions

### Participants
1. **Demo Admin** - Creator (5 completed)
2. **You** - Member (5 completed, 5 reserved)
3. **Alice** - Member (3 completed)
4. **Bob** - Member (2 completed)

### Visual Features to Test

✅ **Completed Units (Green)**
- Lock icon
- Completion date
- Member name

✅ **Reserved Units - Yours (Blue/Primary)**  
- Clock icon for recent ones
- Warning icon for overdue (7+ days)
- Different shades based on age

✅ **Reserved Units - Others (Gray)**
- Lock icon
- Member name
- Reservation date

✅ **Free Units**
- Clean, available state
- Ready to select

✅ **Selected Units (during selection)**
- Checkmark icon
- Highlighted background

### Testing Scenarios

1. **Filter Switching**
   - Switch between all filters
   - Verify counts match
   - Ensure correct units show

2. **Overdue Warnings**
   - Units 11-12 should show ⚠️ warning
   - Check warning badge/color
   - Test admin actions (if admin)

3. **Selection Flow**
   - Select free units (26+)
   - See selected state
   - Confirm button appears
   - Deselect works

4. **Progress Stats**
   - Members stat shows correct percentage
   - Free units percentage correct
   - Completion percentage accurate

## Other Test Khatmas

### "Test Khatma - Cas d'Avertissements" (ID: 0)
- Focus: Overdue reservation warnings
- Various overdue states (1-20 days old)
- Tests reminder functionality

### "Khatma Ramadan 2024" (ID: 1)
- Active khatma with mixed progress
- 8 completed, 4 reserved, rest free
- Tests typical usage pattern

### "Khatma Hebdomadaire" (ID: 2)
- Hizb mode (60 units)
- Higher completion rate
- Tests larger unit counts

### "Test Khatma - Avertissements Rapides" (ID: 3)
- Quick warning tests
- Shorter durations (2-4 days)

### "Khatma Étudiants" (ID: 4)
- Recent khatma (3 days old)
- Early stage progress
- Tests new khatma state

## How to Access Test Data

The test data is automatically loaded when the app starts. To access the test khatma:

1. Navigate to the khatma list
2. Look for "🧪 Test All Filters - Demo Khatma" (should be first)
3. Tap to open the details screen
4. Use filter chips to test different views

## Resetting Test Data

The mock data resets every time the app restarts. No persistent changes are saved.
