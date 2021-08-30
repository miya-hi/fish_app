class Api::FishesController < Api::BaseController

  def index
    if params[:line].present?
      @fishes = Fish.where(line: to_kana_line_list(params[:line])).order(line: :asc).all
    else
      render json: { error: '選択してください' }, status: :bad_request
      return
    end
  end

  def show
    @fish = Fish.find(params[:id])
  end

  private

  def to_kana_line_list(line)
    case line
    when 'あ'
      ["あ", "い", "う", "え", "お"]
    when 'か'
      ["か", "き", "く", "け", "こ"]
    when 'さ'
      ["さ", "し", "す", "せ", "そ"]
    when 'た'
      ["た", "ち", "つ", "て", "と"]
    when 'な'
      ["な", "に", "ぬ", "ね", "の"]
    when 'は'
      ["は", "ひ", "ふ", "へ", "ほ"]
    when 'ま'
      ["ま", "み", "む", "め", "も"]
    when 'や'
      ["や", "ゆ", "よ"]
    when 'ら'
      ["ら", "り", "る", "れ", "ろ"]
    when 'わ'
      ["わ"]
    end
  end
end
