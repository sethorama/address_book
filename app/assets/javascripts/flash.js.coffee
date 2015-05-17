$(".notice, .error", ".success").on("click", (event)->
    $(event.target).hide("slow")
  )