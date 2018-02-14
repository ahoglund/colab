# Colab

To start:

  * Install dependencies with `mix deps.get`
  * Create and migrate database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Models:

  User:          represents the singular person that has signed up with an email/password

  Creator:       an abstraction of a user that represents the person who created a specific collaboration. (is same as Colaborator Model?)

  Collaborator:  an abstraction of a user that represent a non-creator member of a collaboration

  Collaboration: a group with 1 creator and many collaborators, all of which are abstractions of users

  Collaborative: a top level group created alongside a user which is the container of many collaborations

  Lab:           represents a singular 'room' that any members of a collaboration can create

  A **User** has 1 **Collaborator** Account, which can be a **Creator** of a **Collaboration**. Created at registration

  A **Collaborator** has 1 **Collaborative**, deeming it as the **Owner** of the **Collaborative**. Created alongside the user upon registration

  A **Collaborative** has many **Collaborations**, which can be created by the **Creator** of the parent **Collaborative**

  A **Collaboration** has 1 **Creator** and many **Collaborators**

  A **Collaboration** has many **Labs**, which can be created by any **Collaborator** in the **Collaboration**

  A **Collaborator** has and belongs to many **Collaborations** . this implies a join table between collaborators and collaborations

  A **Lab** belongs to a specific **Collaboration**, and has many **Collaborators**. The **Collaborators** in the **Lab** must be members of the owning **Collaboration**
