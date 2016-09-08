# SCT
State Chart Toolkit is a toolkit aimed at APEX designers wanting to simplify the construction of complex forms.
## The problem with complex forms
A complex form in APEX requires many JavaScript based interactions to be coded by an APEX developer. This is normally achieved by creating Dynamic Actions (DA) on the page. This declarative approach is best suited for minor to medium complex pages but it becomes a nightmare to maintain once many items are on the page or once a more sophisticated control over the page elements is required.

If many page items need to be deactivated, hidden, validated or refreshed based on the state of the items on the page, the necessary DA to achieve this overflow the page. While being declarative and easy to use one by one, the interaction and interdependecies between many DA on the page is hard to maintain, leading to a maintenance nightmare if requirements change.

Plus, it's by no means easy to decide which DA causes what behaviour on the page, nor is it easy to debug or test complex DA constructs

This all leads to the best practice to try and avoid overly complex forms in APEX and, should this not be possible, avoid DA in favour of a specialized JavaScript file implementing the necessary logic in JavaScript.

## The approach of State Chart Toolkit

Here, SCT steps in with a new approach. Rather than trying to control many DA on a page, all of them are replace by a single DA, controlling a greater number of items in one go. Despite the DA approach of implementing logic outside the server in JavaScript, SCT implements the logic within the database, moving case trees to a SQL expression.

The basic principle is already known as a [Decision Table](https://en.wikipedia.org/wiki/Decision_table) pattern. But SCT is not an implementation of that pattern in PL/SQL or SQL but lends some basic ideas of this pattern to allow for a meta data driven approach to controling complex state on an APEX page.

To achive this, SCT introduces the concept of *Rule Groups* which collect as many *Rules* as you like in an ordered fashion. Each rule on the other hand is composed of a condition, written in SQL syntax (as if it were part of a `where`-clause) and a collection of *Actions*. These actions get executed in the order that is defined within the rule. Each action on the other hand has a PL/SQL- and JavaScript branch allowing for simultaneous execution of server side and client side code with one action.

To make it easier for a developer to create actions, an action is a reference to an *Action Type* that defines the actions to take.

## Example

Imagine a rule set that shall execute a very simple task: Based on the value of a *Selection List* in APEX, it decides whether to show or not to show a child *Select List* item. Problem is that the decision is based on a database query: if child records exist, the page refreshes and shows the child item, otherwise it shows a placeholder item indicating that no child records exist. This item is to be rendered as a *Display Only* item. To make things more interesting, no submit of the page is allowed, anything happens on a single page life cycle.

### The APEX approach

To decide whether to show or hide the child item or its placeholder item, a DA has to be created that fires if the parent select list item changes. It reads the new value, goes to the database ands find out whether a child record exists. This decision is stored in a hidden element on the page (you can't declaratively execute other JavaScript tasks based on the outcome of an action within a DA). As soon as this hidden element changes, a second DA fires to find out which child item to show or hidde. Plus, it needs to refresh the child select list if a child record was found.

The latter is not required to be coded by a DA because you might define the parent select list for the child select list. If the parent changes, the child select list gets refreshed. The other DA to adjust visibility of the elements are required in any case.

Although this is not overly complex, you see that the following extras are required:

- A hidden element to retrieve the information whether child records exist or not
- A roundtrip to the server to find out whether child records exist or not
- A roundtrip to the server to refresh the child select list.
- Two DA to control the flow

Also, keep in mind that the child select list will refresh anyway, regardless of whether child records exist or not. Even if you optimize refresh this will only avoid a roundtrip if the parent select list changes to NULL.

## The SCT approach

In SCT, you define a rule group using a dedicated APEX application. You define the Application- and Page ID the rule group references and give it a descriptive name.

Next, you define two rules for this rule group: `<item> has children` and `<item> has no children`. As a rule to decide whether the parent item has children or not, you create a small function, taking the parent items actual value und retrieving `Y` or `N` to indicate whether child records exist. Image a function called `has_children(p_parent_id)` for that. Based on this function, you define the rules condition to be `has_children(item) = 'Y'` and `has_children(item) = 'N'` respectively.

The column `item` in the example are column names derived from the item name on the page. So fi, if the page item is called `P2_PARENT`, a column named `parent` is provided with the item's actual content as its column value.

As actions for rule *<item> has children* you define that three things are going to happen:

- *<child_item>* shall refresh
- *<child_item>* shall show
- *<placeholder_item>* shall hide

And the second rule reads:

- *<placeholder_item>* shall show
- *<child_item>* shall be set to NULL and hidden

That's all there is to it. No hidden element on the page, no sepcialized DA anymore. If you run the page, you will see that the items behave as expected.

How could this happen?

## How it works

### General flow

On every page you want SCT to take control for, you implement a single DA per rule group you define for that page. This DA fires on *Page Load* and does not require any parameterization beside the name of the rule group it belongs to. No event handlers, no additional JavaScript code is required on the page.

If the DA initializes, it is told which elements to bind by the database. Plus, it is told which element values the database is interested in. On any occurence of a change event on any bound element, all actual element values of all fields of interested are sent to the database plus the information of which element caused the execution. After initialization, the plugin fires one time to allow the database to initialize the state of the elements based on the actual content of the items (Keep in mind that the session state might be out of sync when initially showing the page. A default value for an item is known to the browser but not to the session state, for example).

This information is the basis for the meta data to decide upon the next actions to take. It will calculate the necessary actions and perform all PL/SQL actions defined within the database. After that, and probably based on the outcome of this execution, JavaScript actions are defined, bundled in a `<script>` tag and resent to the plugin. Plus, all element values calculated or changed at the database are sent to the plugin again, refreshing the values shown at the client.

Should any errors occur during execution they are collected within an error object and passed to the plugin as well. The plugin renders all errors according to the standard AEPX behaviour at the notification box and with the page item.

The plugin executes the script by appending it to the document and immediately afterwards deleting it.

### At the database

If a request comes in, all item values the plugin is interested in were sent to the session state of APEX already. Therefore, it's easy for the database part to get access to the element values in SQL. These values are collected in a dedicated view and presented as columns for the view.

All rule conditions entered were converted to the `where` clause of this view. Based on the item values, one or more conditions may apply. Now the first matching condition (based on a `SORT_SEQ` column for each rule) is retrieved and all defined actions that are connected to this rule.

Should PL/SQL actions be defined for the matching rule, they are executed and the result is persisted at the session state. This sets the session state into a central communication position, allowing for simple API access and maintaining security and session awareness. After all PL/SQL code has been executed, a JavaScript script is put together based on the JavaScript portions of the matching rule actions. This script is sent back as the resonse to the calling plugin.

As an example of the SQL created, review the following code snippet that was created for the scenario in our example (code is for database version 12c, 11g is supported as well):

```
  with session_state as(
       select ':' || sct_admin.get_firing_item || ':' firing_item,
              to_number(v('P1_PARENT'), '9990') PARENT
         from dual)
select /*+ NO_MERGE(s) */ 
       r.sru_id, r.sru_name, r.sru_firing_items,
       r.sra_spi_id, r.sra_sat_id, r.sra_attribute
  from sct_bl_rules r
  join session_state s
    on instr(r.sru_firing_items, s.firing_item) > 0
 where (r.sru_id = 97 and (has_children(parent) = 'Y'))
    or (r.sru_id = 98 and (has_children(parent) = 'N'))
 order by r.sru_sort_seq
 fetch first 1 row with ties
```

### Advantages of this approach

Some important advanteges are realized using this approach:

#### Easier logic control
As all decision logic is presented at a single table within the database (or, even easier, on a page of a dedicated APEX application), it's easier to control complex logic and to see interdependencies

#### Better execution control
A rule is checked only if the triggering element is referenced within the rule condition. This way, only conditions are evaluated that may potentially change based on the triggering element. This avoids unwanted side effects of existing rules.

#### No unrequired DA activities
Nor is it required to create PL/SQL actions with a `NULL` action in order to pass an element value to the database, nor do you need any hidden helper fields on the page to store temporary information. Roundtrips to the database are limited to a total of one per plugin call. Almost no additional roundtrip is required. Additional roundtrips may occur if you want to stick to some declarative functionality APEX exposes, such as when you trigger the `apexrefresh` event. This, in turn, may cause a roundtrip to the database to refresh a report or a select list.

#### Better logic control
Any call to the plugin results in a response from the database that includes the name of the rule that has been chosen for the given state. Plus, in the post to the database, you see each item value that got sent to the database. With this information, it's very easy to follow the logic stream and pin down potential logic flaws.

#### Automatic type detection
If you compare values entered on the page, it's hard to do so because you need to treat date values different than number values and these different to string values. Based on the fact, that each page item is allowed to have a format mask to define the item's appearance on the page, SCT converts the item value to the respective data type using this format mask.

This, on the other hand, means that if you want to treat an item value as a number, you should define a format mask to pass information to SCT on what the item's data type is. Recall that on the APEX page, each item is of type string, as it is in the session state.
