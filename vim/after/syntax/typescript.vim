syn keyword tsAngular2CommonClasses AbstractControl
      \ AbstractControlDirective
      \ AsyncPipe
      \ Control
      \ ControlArray
      \ ControlContainer
      \ ControlGroup
      \ CurrencyPipe
      \ DatePipe
      \ DecimalPipe
      \ FormBuilder
      \ HashLocationStrategy
      \ I18nPluralPipe
      \ I18nSelectPipe
      \ JsonPipe
      \ Location
      \ LocationStrategy
      \ LowerCasePipe
      \ NgControl
      \ NgLocalization
      \ NumberPipe
      \ PathLocationStrategy
      \ PercentPipe
      \ PlatformLocation
      \ RadioButtonState
      \ ReplacePipe
      \ SlicePipe
      \ UpperCasePipe
      \ Validators

syn keyword tsAngular2CommonTestingClasses MockLocationStrategy SpyLocation
syn keyword tsAngular2CompilerClasses AttrAst BoundDirectivePropertyAst BoundElementPropertyAst BoundEventAst BoundTextAst CompileDiDependencyMetadata CompileDirectiveMetadata CompileFactoryMetadata CompileIdentifierMetadata CompileMetadataWithIdentifier CompileMetadataWithType CompilePipeMetadata CompileProviderMetadata CompileQueryMetadata CompileTemplateMetadata CompileTokenMetadata CompileTypeMetadata CompilerConfig DirectiveAst DirectiveResolver ElementAst ElementSchemaRegistry EmbeddedTemplateAst NgContentAst NormalizedComponentWithViewDirectives OfflineCompiler PipeResolver ProviderAst ReferenceAst RenderTypes RuntimeCompiler SourceModule TextAst UrlResolver VariableAst ViewResolver XHR
syn keyword tsAngular2CompilerTestingClasses ComponentFixture MockDirectiveResolver MockSchemaRegistry MockViewResolver MockXHR TestComponentBuilder TestComponentRenderer
syn keyword tsAngular2CoreClasses AbstractProviderError AfterContentChecked AfterContentInit AfterViewChecked AfterViewInit ApplicationRef AttributeMetadata BaseException Binding ChangeDetectorRef CollectionChangeRecord ComponentFactory ComponentMetadata ComponentRef ComponentResolver ContentChildMetadata ContentChildrenMetadata CyclicDependencyError DebugElement DebugNode DefaultIterableDiffer DependencyMetadata DirectiveMetadata DoCheck DynamicComponentLoader ElementRef EmbeddedViewRef EventEmitter ExceptionHandler ExpressionChangedAfterItHasBeenCheckedException HostBindingMetadata HostListenerMetadata HostMetadata InjectMetadata InjectableMetadata Injector InputMetadata InstantiationError InvalidProviderError IterableDiffers KeyValueChangeRecord KeyValueDiffers NgZone NgZoneError NoAnnotationError NoProviderError OnChanges OnDestroy OnInit OpaqueToken OptionalMetadata OutOfBoundsError OutputMetadata PipeMetadata PlatformRef Provider ProviderBuilder QueryList QueryMetadata ReflectionInfo ReflectiveDependency ReflectiveInjector ReflectiveKey Reflector RenderComponentType Renderer ResolvedReflectiveFactory RootRenderer SelfMetadata SimpleChange SkipSelfMetadata SystemJsComponentResolver TemplateRef Testability TestabilityRegistry ViewChildMetadata ViewChildrenMetadata ViewContainerRef ViewMetadata ViewQueryMetadata ViewRef WrappedException WrappedValue
syn keyword tsAngular2CoreTestingClasses InjectSetupWrapper Log MockApplicationRef MockNgZone TestInjector
syn keyword tsAngular2HttpClasses BaseRequestOptions BaseResponseOptions BrowserXhr Connection ConnectionBackend Headers Http JSONPBackend JSONPConnection Jsonp Request RequestOptions Response ResponseOptions URLSearchParams XHRBackend XHRConnection
syn keyword tsAngular2HttpTestingClasses MockBackend MockConnection
syn keyword tsAngular2PlatformBrowserClasses BrowserPlatformLocation By ClientMessageBroker ClientMessageBrokerFactory DomEventsPlugin DomSanitizationService EventManager FnArg HammerGestureConfig KeyEventsPlugin MessageBus ReceivedMessage ServiceMessageBroker ServiceMessageBrokerFactory Title UiArguments WebWorkerInstance
syn keyword tsAngular2PlatformBrowserTestingClasses BrowserDetection
syn keyword tsAngular2PlatformBrowserDynamicTestingClasses DOMTestComponentRenderer
syn keyword tsAngular2PlatformServerClasses Parse5DomAdapter
syn keyword tsAngular2RouterClasses DefaultRouterUrlSerializer Route RouteSegment RouteTree RouterOutletMap RouterUrlSerializer Tree UrlSegment UrlTree
syn keyword tsAngular2RouterDeprecatedClasses AsyncRoute AuxRoute Instruction Redirect Route RouteData RouteParams RouteRegistry Router

syn keyword tsAngular2Constants APP_BASE_HREF COMMON_DIRECTIVES COMMON_PIPES CORE_DIRECTIVES FORM_BINDINGS FORM_DIRECTIVES FORM_PROVIDERS NG_ASYNC_VALIDATORS NG_VALIDATORS NG_VALUE_ACCESSOR workaround_empty_observable_list_diff COMPILER_PROVIDERS DEFAULT_PACKAGE_URL_PROVIDER TEMPLATE_TRANSFORMS ComponentFixtureAutoDetect ComponentFixtureNoNgZone APPLICATION_COMMON_PROVIDERS APP_ID APP_INITIALIZER Attribute ContentChild ContentChildren Host HostBinding HostListener Inject Input Optional Output PACKAGE_ROOT_URL PLATFORM_COMMON_PROVIDERS PLATFORM_DIRECTIVES PLATFORM_INITIALIZER PLATFORM_PIPES Query Self SkipSelf ViewChild ViewChildren ViewQuery reflector wtfCreateScope wtfEndTimeRange wtfLeave wtfStartTimeRange afterEach ddescribe describe expect fdescribe xdescribe HTTP_BINDINGS HTTP_PROVIDERS JSONP_PROVIDERS JSON_BINDINGS BROWSER_APP_COMMON_PROVIDERS BROWSER_APP_STATIC_PROVIDERS BROWSER_PROVIDERS BROWSER_SANITIZATION_PROVIDERS DOCUMENT ELEMENT_PROBE_PROVIDERS EVENT_MANAGER_PLUGINS HAMMER_GESTURE_CONFIG PRIMITIVE WORKER_APP_APPLICATION_COMMON_PROVIDERS WORKER_APP_APPLICATION_PROVIDERS WORKER_APP_LOCATION_PROVIDERS WORKER_APP_PLATFORM_PROVIDERS WORKER_RENDER_APPLICATION_COMMON_PROVIDERS WORKER_RENDER_APPLICATION_PROVIDERS WORKER_RENDER_LOCATION_PROVIDERS WORKER_RENDER_PLATFORM_PROVIDERS WORKER_RENDER_STARTABLE_MESSAGING_SERVICE WORKER_SCRIPT ADDITIONAL_TEST_BROWSER_PROVIDERS TEST_BROWSER_STATIC_APPLICATION_PROVIDERS TEST_BROWSER_STATIC_PLATFORM_PROVIDERS browserDetection expect BROWSER_APP_DYNAMIC_PROVIDERS CACHED_TEMPLATE_PROVIDER WORKER_APP_DYNAMIC_APPLICATION_PROVIDERS WORKER_RENDER_DYNAMIC_APPLICATION_PROVIDERS ADDITIONAL_DYNAMIC_TEST_BROWSER_PROVIDERS TEST_BROWSER_DYNAMIC_APPLICATION_PROVIDERS TEST_BROWSER_DYNAMIC_PLATFORM_PROVIDERS TEST_SERVER_APPLICATION_PROVIDERS TEST_SERVER_PLATFORM_PROVIDERS ROUTER_DIRECTIVES ROUTER_PROVIDERS ROUTER_BINDINGS ROUTER_DIRECTIVES ROUTER_PRIMARY_COMPONENT ROUTER_PROVIDERS ROUTER_PROVIDERS_COMMON

syn keyword tsAngular2RxJs Observable Observer Notification

syn keyword tsAngular2GlobalFuncs createOfflineCompileUrlResolver templateVisitAll Class asNativeElements assertPlatform bind coreBootstrap coreLoadAndBootstrap createNgZone createPlatform disposePlatform enableProdMode forwardRef getDebugNode getPlatform provide resolveForwardRef setTestabilityGetter async beforeEach beforeEachProviders clearPendingTimers containsRegexp fakeAsync fit flushMicrotasks getTestInjector getTypeOf iit inject injectAsync instantiateType it resetBaseTestProviders setBaseTestProviders tick withProviders xit bootstrapStatic bootstrapStaticApp bootstrapStaticRender browserPlatform disableDebugTools enableDebugTools initializeGenericWorkerRenderer workerAppPlatform workerRenderPlatform dispatchEvent el normalizeCSS stringifyElement bootstrap bootstrapApp bootstrapRender

hi def link tsAngular2CommonClasses          Type
hi def link tsAngular2CommonTestingClasses   Type
hi def link tsAngular2CoreClasses            Type
hi def link tsAngular2CoreTestingClasses     Type
hi def link tsAngular2HttpClasses            Type
hi def link tsAngular2HttpTestingClasses     Type
hi def link tsAngular2PlatformBrowserClasses Type
hi def link tsAngular2PlatformBrowserTestingClasses Type
hi def link tsAngular2PlatformBrowserDynamicTestingClasses Type
hi def link tsAngular2PlatformServerClasses  Type
hi def link tsAngular2CompilerClasses        Type
hi def link tsAngular2CompilerTestingClasses Type
hi def link tsAngular2PlatformServerClasses  Type
hi def link tsAngular2RouterClasses          Type
hi def link tsAngular2RouterDeprecatedClasses  Type
hi def link tsAngular2Constants Constant
hi def link tsAngular2RxJs Type
hi def link tsAngular2GlobalFuncs Function
