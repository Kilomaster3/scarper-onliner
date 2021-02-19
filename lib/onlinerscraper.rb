# frozen_string_literal: true

class OnlinerScraper
  LINKS = '//*[contains(@class,"b-tile m-1x1 m-info")]/a[@class="b-tile-main"]'
  IMAGE = '[class="news-header__image"]'
  TEXT = '[class="news-text"]'
  CSS = 'div[class="news-header__title"] > div[class="button-style button-style_special button-style_small button-style_noreflex news-header__button"]'
  NEWS = 'div[class="news-header__title"] > div[class="button-style button-style_special button-style_small button-style_noreflex news-header__button"]'
  NAVIGATION_BAR = '[class="project-navigation__item project-navigation__item_primary project-navigation__item_active"]'

  attr_accessor :browser, :links, :data

  def initialize(browser, _driver)
    @browser = browser
    @links = []
    @data = []
    find_links
  end

  def find_links
    @browser.all(:xpath, LINKS).each { |row| links.push(row['href']) }
  end

  def take_data
    links.each do |link|
      browser.visit link
      name = spec_name?
      image = browser.find(IMAGE)['style']
      text = browser.find(TEXT).text.slice(0, 200)
      data.push(name: name, text: text, image: image)
    end
    data
  end

  def spec_name?
    browser.find(browser.has_css?(CSS) ? NEWS : NAVIGATION_BAR).text
  end
end
