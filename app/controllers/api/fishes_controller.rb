class Api::FishesController < Api::BaseController
  def index
    if params[:line].present?
      @fishes = Fish.where(line: to_kana_line_list(params[:line])).order(line: :asc).all
    else
      render json: { error: '選択してください' }, status: :bad_request and return
    end
  end

  private

  def to_kana_line_list(line)
    case line
    when 'あ'
      ("あ".."お").step(2).to_a
    when 'か'
      ("か".."こ").step(2).to_a
    when 'さ'
      ("さ".."そ").step(2).to_a
    when 'た'
      ("た".."と").step(2).to_a
    when 'な'
      ("な".."の").step(2).to_a
    when 'は'
      ("は".."ほ").step(2).to_a
    when 'ま'
      ("ま".."も").step(2).to_a
    when 'や'
      ("や".."よ").step(2).to_a
    when 'ら'
      ("ら".."ろ").step(2).to_a
    when 'わ'
      ["わ"]
    end
  end
end

# empty nilかどうか
# blank 空文字はOK
