class CommonQuestionsController < ApplicationController
  def index


    what = CommonQuestion.new
    what.question = "What is gCamp?"
    what.answer = "gCamp is an awesome tool that is going to change your life.
    gCamp is your one stop shop to organize all your tasks.  You'll also be able
    to track comments that you and others make.  gCamp may eventually replace all
    need for paper and pens in the entire world.  Well, maybe not, but it's going
    to be pretty cool."
    what.slug = "what-is-gcamp"

    how = CommonQuestion.new
    how.question = "How do I join gCamp?"
    how.answer = "As soon as it's ready for the public, you'll see a signup link
    in the upper right.  Once that's there, just click it and fill in the form!"
    how.slug = "how-do-I-join-gcamp"

    when1 = CommonQuestion.new
    when1.question = "When will gCamp be finished?"
    when1.answer = "gCamp is a work in progress.  That being said, it should be
    fully functional in the next few weeks.  Functional.  Check in daily for new
    features and awesome functionality.  It's going to blow your mind.  Organization
    is just a click away.  Amazing!"
    when1.slug = "when-will-gcamp-be-finished"

    @questions = [what, how, when1]

  end
end