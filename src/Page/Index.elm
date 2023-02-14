module Page.Index exposing (Data, Model, Msg, page)

import DataSource exposing (DataSource)
import Element exposing (..)
import Element.Font as Font
import Element.Input as Input
import Galmuri
import Head
import Head.Seo as Seo
import Page exposing (PageWithState, StaticPayload)
import Pages.PageUrl exposing (PageUrl)
import Pages.Url
import Shared
import View exposing (View)


type alias Model =
    { selectedOS : OS
    , selectedSSD : SSD
    , selectedRAM : RAM
    }


type OS
    = Elementary
    | Ubuntu
    | Windows


type SSD
    = GB128
    | GB256
    | GB512


ssdPrice : SSD -> Int
ssdPrice ssd =
    case ssd of
        GB128 ->
            0

        GB256 ->
            3

        GB512 ->
            5


type RAM
    = GB8
    | GB16


ramPrice : RAM -> Int
ramPrice ram =
    case ram of
        GB8 ->
            0

        GB16 ->
            5


type Msg
    = SelectOS OS
    | SelectSSD SSD
    | SelectRAM RAM


type alias RouteParams =
    {}


page : PageWithState RouteParams Data Model Msg
page =
    Page.single
        { head = head
        , data = data
        }
        |> Page.buildWithLocalState
            { view = view
            , init =
                \_ _ _ ->
                    ( { selectedOS = Elementary
                      , selectedSSD = GB128
                      , selectedRAM = GB8
                      }
                    , Cmd.none
                    )
            , subscriptions = \_ _ _ _ -> Sub.none
            , update =
                \_ _ _ _ msg model ->
                    case msg of
                        SelectOS newOS ->
                            ( { model | selectedOS = newOS }, Cmd.none )

                        SelectSSD newSSD ->
                            ( { model | selectedSSD = newSSD }, Cmd.none )

                        SelectRAM newRAM ->
                            ( { model | selectedRAM = newRAM }, Cmd.none )
            }


type alias Data =
    ()


data : DataSource Data
data =
    DataSource.succeed ()


head :
    StaticPayload Data RouteParams
    -> List Head.Tag
head static =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "ThinkPad X230 (Hacker Edition)"
        , image =
            { url = Pages.Url.external "TODO"
            , alt = "elm-pages logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "ThinkPad X230"
        , locale = Nothing
        , title = "ThinkPad X230 (Hacker Edition)"
        }
        |> Seo.website


view :
    Maybe PageUrl
    -> Shared.Model
    -> Model
    -> StaticPayload Data RouteParams
    -> View Msg
view maybeUrl sharedModel model static =
    { title = "x230"
    , body =
        column [ spacing 40 ]
            [ el [ height (px 200) ] none
            , textColumn [ spacing 8 ]
                [ paragraph Galmuri.title [ text "ThinkPad X230 (Hacker Edition)" ]
                , paragraph
                    (Galmuri.galmuri11 1
                        ++ [ paddingEach { left = 6, right = 0, top = 0, bottom = 0 } ]
                    )
                    [ text "все как для себя" ]
                ]
            , para "Что такое ThinkPad X230"
                [ [ text "ThinkPad X230 считается последним и лучшим ноутбуком марки \"ThinkPad\" старой закалки. Модельный ряд \"X\" состоит из самых премиальных и компактных моделей ThinkPad. ", a "https://youtu.be/IK1GAiQYQe8" "Модель X230 была создана как неубиваемая", text " — у нee даже есть сливы для воды!" ]
                , [ text "Несмотря на возраст, ноутбук работает на процессорах i5 и i7. Мощности этих процессоров хватает для любых задач — я сам пользуюсь этой моделью каждый день." ]
                , [ text "Здесь возраст устройства это огромный плюс! Модель X230 отлично поддерживает все свободные дистрибутивы Linux, и даже имеет свободную альтернативу BIOS. Это самый мощный ноутбук, на котором можно избавиться даже от "
                  , a "https://ru.wikipedia.org/wiki/Intel_Management_Engine" "Intel Managnment Engine"
                  , text " и перейти полностью на "
                  , a "https://ru.wikipedia.org/wiki/%D0%A1%D0%B2%D0%BE%D0%B1%D0%BE%D0%B4%D0%BD%D0%BE%D0%B5_%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%BD%D0%BE%D0%B5_%D0%BE%D0%B1%D0%B5%D1%81%D0%BF%D0%B5%D1%87%D0%B5%D0%BD%D0%B8%D0%B5" "свободное ПО"
                  , text "!"
                  ]
                ]
            , para "Чем отличается Hacker Edition"
                [ [ text "1. BIOS перепрошит на ", a "https://libreboot.org/" "Libreboot", text "." ]
                , [ text "2. Клавиатура заменена на ", a "https://www.thinkwiki.org/wiki/Install_Classic_Keyboard_on_xx30_Series_ThinkPads" "легендарную клавиатуру от модели X220", text ". Очень приятная тактильная отдача как на оригинале." ]
                , [ text "3. Экран земенен на технологию IPS. Угол обзора и передача цветов сильно лучше, чем на оригинальном дисплее технологии TN." ]
                , [ text "4. Все детали, которых вы касаетесь при использовании, были заменены на новые." ]
                , [ text "5. Батарея заменена на новую." ]
                , [ text "6. Термопаста заменена на новую." ]
                , [ text "7. Жетский диск заменен на SSD." ]
                , [ text "8. В комплекте есть переходник для зарядки через USB-C." ]
                ]
            , para "Доставка"
                [ [ text "Доставка по всей России ", a "https://www.avito.ru/dostavka" "Авито Доставкой", text "." ]
                ]
            , paragraph (Galmuri.body ++ []) [ text "Остались вопросы? Пиши на ", a "mailto:x230@iko.soy" "x230@iko.soy", text "." ]
            , row [ width fill ]
                [ column [ width (fillPortion 1), spacing 12, alignTop ]
                    [ paragraph Galmuri.subtitle [ text "Выбери OS" ]
                    , Input.radio (Galmuri.body ++ [ spacing 12 ])
                        { label = Input.labelHidden "OS"
                        , onChange = SelectOS
                        , options =
                            [ Input.option Elementary (text "elementary OS 7")
                            , Input.option Ubuntu (text "Ubuntu 22.10")
                            , Input.option Windows (text "Windows 10")
                            ]
                        , selected = Just model.selectedOS
                        }
                    ]
                , column [ width (fillPortion 1), spacing 12, alignTop ]
                    [ paragraph Galmuri.subtitle [ text "Выбери SSD" ]
                    , Input.radio (Galmuri.body ++ [ spacing 12 ])
                        { label = Input.labelHidden "SSD"
                        , onChange = SelectSSD
                        , options =
                            [ Input.option GB128 (text "128 GB")
                            , Input.option GB256 (text "256 GB")
                            , Input.option GB512 (text "512 GB")
                            ]
                        , selected = Just model.selectedSSD
                        }
                    ]
                , column [ width (fillPortion 1), spacing 12, alignTop ]
                    [ paragraph Galmuri.subtitle [ text "Выбери RAM" ]
                    , Input.radio (Galmuri.body ++ [ spacing 12 ])
                        { label = Input.labelHidden "RAM"
                        , onChange = SelectRAM
                        , options =
                            [ Input.option GB8 (text "8 GB")
                            , Input.option GB16 (text "16 GB")
                            ]
                        , selected = Just model.selectedRAM
                        }
                    ]
                ]
            , el [ width fill ] (row (Galmuri.subtitle ++ [ centerX, spacing 32 ]) [ text (String.fromInt (price model) ++ ",000₽"), a "https://www.avito.ru/yaroslavl/noutbuki/thinkpad_x230_hacker_edition_2788730045" "Купить" ])
            ]
    }


price : Model -> Int
price model =
    35 + ssdPrice model.selectedSSD + ramPrice model.selectedRAM


para : String -> List (List (Element msg)) -> Element msg
para heading txts =
    textColumn [ spacing 12 ] <|
        paragraph Galmuri.subtitle [ text heading ]
            :: List.map
                (paragraph
                    (Galmuri.body
                        ++ [ paddingEach
                                { top = 0
                                , right = 0
                                , bottom = 0
                                , left = 32
                                }
                           ]
                    )
                )
                txts


a : String -> String -> Element msg
a href label =
    newTabLink [ Font.underline ] { url = href, label = text label }
