module FormHelper
  class FormWithErrorMessageBuilder < ActionView::Helpers::FormBuilder
    def input_field_with_error(attribute, options={}, &block)
      # 入力フォームと同じ属性のエラーメッセージを取得する
      error_messages = @object.errors.full_messages_for(attribute)

      # エラーがある場合のみ、エラー用のHTMLにする
      if error_messages.any?
        # options[:class] << "error-class"
        error_contents = create_error_div(attribute, error_messages)
      end

      # 従来の入力フォーム と 生成されたエラーメッセージ を連結して返す
      block.call + error_contents || ""
    end

    # エラーメッセージのHTMLタグを作成する
    def create_error_div(attribute, messages)
      # content_tag でHTMLタグを生成
      @template.content_tag(:div, class: "error-class") do
        messages.each do |message|
          @template.concat(@template.content_tag(:div, message))
        end
      end
    end

    # 既存のビューヘルパーメソッドをオーバーライドする
    def text_field(attribute, options={})
      input_field_with_error(attribute, options) do
         super
      end
    end
    def email_field(attribute, options={})
      input_field_with_error(attribute, options) do
    super
      end
    end
    def password_field(attribute, options={})
      input_field_with_error(attribute, options) do
    super
      end
    end
  end
end
