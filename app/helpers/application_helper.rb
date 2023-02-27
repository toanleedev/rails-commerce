module ApplicationHelper
  def toastr_flash
    flash.each_with_object([]) do |(type, message), flash_messages|
      type = 'bg-success' if type == 'notice'
      type = 'bg-danger' if type == 'alert'
      text = "<div class='toast align-items-center text-white #{type} border-0 position-fixed m-3 bottom-0 end-0' role='alert' aria-live='assertive' aria-atomic='true'><div class='d-flex'><div class='toast-body'>#{message}</div><button type='button' class='btn-close btn-close-white me-2 m-auto' data-bs-dismiss='toast' aria-label='Close'></button></div></div>"
      flash_messages << text.html_safe if message
    end.join("\n").html_safe
  end
end
